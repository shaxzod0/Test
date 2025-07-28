//
//  ProfileCoordinator.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let actions = ProfileViewModelActions()
        let viewModel = ProfileViewModel(actions: actions)
        let profileViewController = ProfileController.create(with: viewModel)
        navigationController.pushViewController(profileViewController, animated: false)
    }
    
    func finish() {
        childCoordinators.removeAll()
    }
}
