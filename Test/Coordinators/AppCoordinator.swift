//
//  AppCoordinator.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    let favoritesService: FavoritesServiceProtocol = FavoritesService()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        startMainTabBar()
    }
    
    private func startMainTabBar() {
        let tabBarCoordinator = MainTabBarCoordinator(navigationController: navigationController, favoritesService: favoritesService)
        addChildCoordinator(tabBarCoordinator)
        tabBarCoordinator.start()
    }
}

// MARK: - MainTabBarCoordinator
class MainTabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let tabBarController = UITabBarController()
    
    private let favoritesService: FavoritesServiceProtocol
    
    init(
        navigationController: UINavigationController,
        favoritesService: FavoritesServiceProtocol
    ) {
        self.navigationController = navigationController
        self.favoritesService = favoritesService
    }
    
    func start() {
        setupTabBar()
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    private func setupTabBar() {
        let favoritesNavController = UINavigationController()
        let favoritesCoordinator = FavoritesCoordinator(navigationController: favoritesNavController)
        addChildCoordinator(favoritesCoordinator)
        favoritesCoordinator.start()
        favoritesNavController.tabBarItem = UITabBarItem(
            title: "",
            image: .icBookmark,
            selectedImage: .icBookmark
        )
        favoritesNavController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        let mapNavController = UINavigationController()
        let mapCoordinator = MapCoordinator(navigationController: mapNavController, favoritesService: favoritesService)
        addChildCoordinator(mapCoordinator)
        mapCoordinator.start()
        mapNavController.tabBarItem = UITabBarItem(
            title: "",
            image: .icLocation,
            selectedImage: .icLocation
        )
        mapNavController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        let profileNavController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavController)
        addChildCoordinator(profileCoordinator)
        profileCoordinator.start()
        profileNavController.tabBarItem = UITabBarItem(
            title: "",
            image: .icProfile,
            selectedImage: .icProfile
        )
        profileNavController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        tabBarController.navigationController?.isNavigationBarHidden = true
        tabBarController.viewControllers = [favoritesNavController, mapNavController, profileNavController]
        tabBarController.tabBar.backgroundColor = .white
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        tabBarController.tabBar.layer.cornerRadius = 12
        tabBarController.tabBar.layer.masksToBounds = true
        tabBarController.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
