//  
//  MapController.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit

class MapController: UIViewController, ViewSpecificController {
    
    // MARK: - ROOTVIEW
    
    typealias RootView = MapRootView

    // MARK: - ATTRIBUTES
    
    private var viewModel: MapViewModel!
    
    // MARK: - LIFECYCLE
    
    static func create(with viewModel: MapViewModel) -> MapController {
        let controller = MapController()
        controller.viewModel = viewModel
        return controller
    }
    
    override func loadView() {
        super.loadView()
        view = MapRootView(viewModel: viewModel)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func bindViewModel() {
        
    }
}
