//  
//  PlaceDetailsRootView.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit

final class PlaceDetailsRootView: UIView {
    
    // MARK: - OUTLETS
    private lazy var placeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.icClose.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private lazy var addToFavorite: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Добавить в избранное", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .button
        return button
    }()
    // MARK: - DEPENDENCIES
    
    private let viewModel: PlaceDetailsViewModel
    
    // MARK: - LIFECYCLE
    
    init(viewModel: PlaceDetailsViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        clipsToBounds = true
        self.backgroundColor = .white
        placeName.text = viewModel.placeDetails.name
        addressLabel.text = viewModel.placeDetails.address
        setupSubviews()
        configureConstraints()
        
        addToFavorite.addAction(.init { [weak self] _ in
            guard let self else { return }
            viewModel.addToFavorites()
        }, for: .touchUpInside)
    }
    
    private func setupSubviews() {
        addSubview(placeName)
        addSubview(addressLabel)
        addSubview(closeButton)
        addSubview(addToFavorite)
    }
    
    private func configureConstraints() {
        closeButton.setSize(24)
        closeButton.top(toView: self, constant: 16)
        closeButton.right(toView: self, constant: 16)
        
        placeName.top(toView: self, constant: 16)
        placeName.left(toView: self, constant: 16)
        placeName.relativeRight(toView: closeButton, constant: 8)
        
        addressLabel.left(toView: self, constant: 16)
        addressLabel.right(toView: self, constant: 16)
        addressLabel.relativeTop(toView: placeName, constant: 8)
        
        addToFavorite.left(toView: self, constant: 16)
        addToFavorite.height(equalTo: 42)
        addToFavorite.relativeTop(toView: addressLabel, constant: 16)
        addToFavorite.width(equalTo: 220)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addToFavorite.layer.masksToBounds = true
        addToFavorite.layer.cornerRadius = addToFavorite.bounds.height / 2
    }
}

