//  
//  MapRepository.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import Foundation
import YandexMapsMobile

class MapRepository: MapRepositoryProtocol{
    private let searchManager: YMKSearchManager
    private var searchSession: YMKSearchSession?
    
    init() {
        self.searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
    }
    
    func searchPlaces(query: String, userLocation: YMKPoint?, completion: @escaping (Result<[SearchResult], Error>) -> Void) {
        guard !query.isEmpty else {
            completion(.success([]))
            return
        }
        searchSession?.cancel()
        let searchOptions = YMKSearchOptions()
        searchOptions.searchTypes = .biz
        searchOptions.resultPageSize = NSNumber(value: 20)
        let searchCenter = userLocation ?? YMKPoint(latitude: 41.311081, longitude: 69.240562)
        let geometry = YMKGeometry(point: searchCenter)
        searchSession = searchManager.submit(
            withText: query,
            geometry: geometry,
            searchOptions: searchOptions,
            responseHandler: { [weak self] (searchResponse: YMKSearchResponse?, error: Error?) in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    guard let response = searchResponse else {
                        completion(.failure(NSError(domain: "SearchRepository", code: -1, userInfo: [NSLocalizedDescriptionKey: "No response received"])))
                        return
                    }
                    
                    let results = self?.parseSearchResponse(response, referencePoint: searchCenter) ?? []
                    completion(.success(results))
                }
            }
        )
    }
    
    private func parseSearchResponse(_ response: YMKSearchResponse, referencePoint: YMKPoint) -> [SearchResult] {
        var searchResults: [SearchResult] = []
        
        for item in response.collection.children {
            guard let geoObject = item.obj else { continue }
            
            let name = geoObject.name ?? "Unknown Place"
            let description = geoObject.descriptionText ?? ""
            
            guard let point = geoObject.geometry.first?.point else { continue }
            let latitude = point.latitude
            let longitude = point.longitude
            
            var address = ""
            if !description.isEmpty {
                address = description
            } else if !name.isEmpty {
                address = name
            } else {
                address = "Location at \(String(format: "%.4f", latitude)), \(String(format: "%.4f", longitude))"
            }
            
            let distance = calculateDistance(from: referencePoint, to: point)
            
            let result = SearchResult(
                id: UUID().uuidString,
                name: name,
                address: address,
                distance: formatDistance(distance),
                latitude: latitude,
                longitude: longitude,
                category: nil,
                rating: nil,
                isOpen: nil
            )
            
            searchResults.append(result)
        }
        
        // Sort by distance
        return searchResults.sorted {
            let distance1 = calculateDistance(from: referencePoint, to: YMKPoint(latitude: $0.latitude, longitude: $0.longitude))
            let distance2 = calculateDistance(from: referencePoint, to: YMKPoint(latitude: $1.latitude, longitude: $1.longitude))
            return distance1 < distance2
        }
    }
    
    private func calculateDistance(from: YMKPoint, to: YMKPoint) -> Double {
        // Simple distance calculation in meters using Haversine formula
        let earthRadius: Double = 6371000 // Earth radius in meters
        
        let lat1Rad = from.latitude * .pi / 180
        let lat2Rad = to.latitude * .pi / 180
        let deltaLatRad = (to.latitude - from.latitude) * .pi / 180
        let deltaLonRad = (to.longitude - from.longitude) * .pi / 180
        
        let a = sin(deltaLatRad / 2) * sin(deltaLatRad / 2) +
        cos(lat1Rad) * cos(lat2Rad) *
        sin(deltaLonRad / 2) * sin(deltaLonRad / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        
        return earthRadius * c
    }
    
    private func formatDistance(_ distance: Double) -> String {
        if distance < 1000 {
            return String(format: "%.0f м", distance)
        } else {
            return String(format: "%.1f км", distance / 1000)
        }
    }
}
