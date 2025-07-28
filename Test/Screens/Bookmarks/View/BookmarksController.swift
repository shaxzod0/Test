//  
//  BookmarksController.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit
import Foundation

class BookmarksController: UIViewController, ViewSpecificController {
    
    // MARK: - ROOTVIEW
    
    typealias RootView = BookmarksRootView

    // MARK: - ATTRIBUTES
    
    private var viewModel: BookmarksViewModel!
    
    // MARK: - LIFECYCLE
    
    static func create(with viewModel: BookmarksViewModel) -> BookmarksController {
        let controller = BookmarksController()
        controller.viewModel = viewModel
        return controller
    }
    
    override func loadView() {
        super.loadView()
        view = BookmarksRootView(viewModel: viewModel)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadData),
            name: .updateBookmarks,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func bindViewModel() {
        
    }
    
    @objc func reloadData() {
        viewModel.loadBookmarks()
    }
}
