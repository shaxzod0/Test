//  
//  ProfileRootView.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit

final class ProfileRootView: UIView {
    
    // MARK: - OUTLETS
    
    // MARK: - DEPENDENCIES
    
    private let viewModel: ProfileViewModel
    
    // MARK: - LIFECYCLE
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        clipsToBounds = true
        setupSubviews()
        configureConstraints()
    }
    
    private func setupSubviews() {
        
    }
    
    private func configureConstraints() {
        
    }
}

