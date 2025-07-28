//  
//  ProfileController.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit

class ProfileController: UIViewController, ViewSpecificController {
    
    // MARK: - ROOTVIEW
    
    typealias RootView = ProfileRootView

    // MARK: - ATTRIBUTES
    
    private var viewModel: ProfileViewModel!
    
    // MARK: - LIFECYCLE
    
    static func create(with viewModel: ProfileViewModel) -> ProfileController {
        let controller = ProfileController()
        controller.viewModel = viewModel
        return controller
    }
    
    override func loadView() {
        super.loadView()
        view = ProfileRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func bindViewModel() {
        
    }
}
