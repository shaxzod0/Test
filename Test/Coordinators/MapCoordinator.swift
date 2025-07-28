//
//  MapCoordinator.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit

protocol MapCoordinatorDelegate: AnyObject {
    func showPlaceDetails()
}

class MapCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let favoritesService: FavoritesServiceProtocol
    
    private lazy var placeDetailsRepository = PlaceDetailsRepository(favoriteService: favoritesService)
    private lazy var mapRepository: any MapRepositoryProtocol = MapRepository()
    
    private var mapViewModel: MapViewModel?
    
    init(
        navigationController: UINavigationController,
        favoritesService: FavoritesServiceProtocol
    ) {
        self.navigationController = navigationController
        self.favoritesService = favoritesService
    }
    
    func start() {
        let actions = MapViewModelActions(
            showPlaceDetails: showPlaceDetails(_:)
        )
        let viewModel = MapViewModel(repository: mapRepository, actions: actions)
        self.mapViewModel = viewModel
        let mapViewController = MapController.create(with: viewModel)
        navigationController.pushViewController(mapViewController, animated: false)
    }
    
    func moveToLocation(_ searchResult: SearchResult) {
        mapViewModel?.moveMapToLocation(searchResult)
    }
    
    func showPlaceDetails(_ place: SearchResult) {
        let action = PlaceDetailsViewModelActions()
        let viewModel = PlaceDetailsViewModel(
            repository: placeDetailsRepository,
            actions: action,
            placeDetails: place
        )
        let placeDetailsViewController = PlaceDetailsController.create(with: viewModel)
        navigationController.presentPanModal(placeDetailsViewController)
    }
}
