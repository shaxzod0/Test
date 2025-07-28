//
//  MapViewModel.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit
import CoreLocation
import YandexMapsMobile

struct MapViewModelActions {
    let showPlaceDetails: (_ details: SearchResult) -> Void
}

class MapViewModel: NSObject {
    
    var searchedAddress: Dynamic<String> = Dynamic<String>("")
    var userLocation: Dynamic<CLLocation?> = Dynamic<CLLocation?>(nil)
    var showLoading: Dynamic<Bool> = Dynamic<Bool>(false)
    let repository: MapRepositoryProtocol
    
    private let actions: MapViewModelActions
    private let locationManager = CLLocationManager()
    private var mapView: YMKMapView?
    private var userLocationPlacemark: YMKPlacemarkMapObject?
    
    var searchResult: Dynamic<[SearchResult]> = Dynamic<[SearchResult]>([])
    
    var itemsCount: Int {
        return searchResult.value.count
    }
    
    init(
        repository: MapRepositoryProtocol,
        actions: MapViewModelActions
    ) {
        self.actions = actions
        self.repository = repository
        super.init()
        setupLocationManager()
    }
    
    func setMapView(_ mapView: YMKMapView) {
        self.mapView = mapView
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationPermission() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            showLocationPermissionAlert()
        case .authorizedWhenInUse, .authorizedAlways:
            startLocationUpdates()
        @unknown default:
            break
        }
    }
    
    func locateMe() {
        requestLocationPermission()
    }
    
    private func startLocationUpdates() {
        guard CLLocationManager.locationServicesEnabled() else { return }
        guard locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways else { return }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.locationManager.startUpdatingLocation()
        }
    }
    
    private func moveMapToUserLocation(_ location: CLLocation) {
        guard let mapView = mapView else { return }
        
        let point = YMKPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let cameraPosition = YMKCameraPosition(target: point, zoom: 16, azimuth: 0, tilt: 0)
        
        mapView.mapWindow.map.move(
            with: cameraPosition,
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1.0),
            cameraCallback: nil
        )
        
        showUserLocationMarker(at: point)
    }
    
    private func showUserLocationMarker(at point: YMKPoint) {
        guard let mapView = mapView else { return }
        if let existingMarker = userLocationPlacemark {
            mapView.mapWindow.map.mapObjects.remove(with: existingMarker)
        }
        userLocationPlacemark = mapView.mapWindow.map.mapObjects.addPlacemark(with: point)
        userLocationPlacemark?.setIconWith(.icLocate)
        userLocationPlacemark?.opacity = 1.0
        userLocationPlacemark?.isDraggable = false
    }
    
    private func showLocationPermissionAlert() {
        print("Location permission denied. Please enable location access in Settings.")
    }
    
    func showPlaceDetails(_ place: SearchResult) {
        actions.showPlaceDetails(place)
    }
    
    func moveMapToLocation(_ searchResult: SearchResult) {
        guard let mapView = mapView else { return }
        
        let point = YMKPoint(latitude: searchResult.latitude, longitude: searchResult.longitude)
        let cameraPosition = YMKCameraPosition(target: point, zoom: 16, azimuth: 0, tilt: 0)
        mapView.mapWindow.map.move(
            with: cameraPosition,
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1.0),
            cameraCallback: nil
        )
        showLocationMarker(at: point, for: searchResult)
    }
    
    private func showLocationMarker(at point: YMKPoint, for searchResult: SearchResult) {
        guard let mapView = mapView else { return }
        
        // Create marker for the selected location
        let placemark = mapView.mapWindow.map.mapObjects.addPlacemark(with: point)
        placemark.setIconWith(.icPlacement)
        placemark.opacity = 1.0
        placemark.isDraggable = false
        
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation.value = location
        moveMapToUserLocation(location)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            startLocationUpdates()
        case .denied, .restricted:
            showLocationPermissionAlert()
        default:
            break
        }
    }
}


extension MapViewModel {
    func performSearch(query: String) {
        guard !query.isEmpty else {
            searchResult.value = []
            return
        }
        showLoading.value = true
        guard let userLocation = userLocation.value else {
            showLoading.value = false
            return
        }
        
        repository.searchPlaces(query: query, userLocation: .init(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(result):
                showLoading.value = false
                searchResult.value = result
            case let .failure(error):
                showLoading.value = false
                searchResult.value = []
                print("Search error: \(error.localizedDescription)")
            }
        }
    }
    
    func getItemAt(_ index: Int) -> SearchResult? {
        searchResult.value[safe: index]
    }
}
