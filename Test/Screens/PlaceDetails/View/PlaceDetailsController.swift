//  
//  PlaceDetailsController.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit

class PlaceDetailsController: UIViewController, ViewSpecificController {
    
    // MARK: - ROOTVIEW
    
    typealias RootView = PlaceDetailsRootView
    private var isShortFormEnabled = true

    // MARK: - ATTRIBUTES
    
    private var viewModel: PlaceDetailsViewModel!
    
    // MARK: - LIFECYCLE
    
    static func create(with viewModel: PlaceDetailsViewModel) -> PlaceDetailsController {
        let controller = PlaceDetailsController()
        controller.viewModel = viewModel
        return controller
    }
    
    override func loadView() {
        super.loadView()
        view = PlaceDetailsRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.savingState.bindAndFire { [weak self] state in
            guard let self else { return }
            if state {
                dismiss(animated: true)
            }
        }
    }
}

extension PlaceDetailsController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var shortFormHeight: PanModalHeight {
        .contentHeight(300)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
    var scrollIndicatorInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func willTransition(to state: PanModalPresentationController.PresentationState) {
        guard isShortFormEnabled, case .longForm = state
        else { return }
        
        isShortFormEnabled = false
        panModalSetNeedsLayoutUpdate()
    }
    
    
}
