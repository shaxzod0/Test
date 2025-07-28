//
//  FavoritesCoordinator.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit

protocol FavoritesCoordinatorDelegate: AnyObject {
    func navigateToMap(with searchResult: SearchResult)
}

class FavoritesCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    weak var delegate: FavoritesCoordinatorDelegate?
    
    private let favoritesService: FavoritesServiceProtocol
    
    private lazy var bookmarkRepository: BookmarksRepository = .init(manager: favoritesService)
    
    init(navigationController: UINavigationController,
         favoritesService: FavoritesServiceProtocol = FavoritesService()) {
        self.navigationController = navigationController
        self.favoritesService = favoritesService
    }
    
    func start() {
        let actions = BookmarksViewModelActions(
            onBookmarkSelected: { [weak self] bookmark in
                self?.delegate?.navigateToMap(with: bookmark)
            }
        )
        let viewModel = BookmarksViewModel(favoritesService: favoritesService, actions: actions)
        let bookmarksViewController = BookmarksController.create(with: viewModel)
        bookmarksViewController.title = "Мои адреса"
        navigationController.pushViewController(bookmarksViewController, animated: false)
    }
}
