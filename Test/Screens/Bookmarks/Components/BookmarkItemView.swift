//
//  BookmarkItemView.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit
import SwiftUI

final class BookmarkItemView: UIView {
    
    // MARK: - UI Components
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bookmarkIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .icLocationFavorite
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(with model: BookmarksItemProvider) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(bookmarkIcon)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.fillSides(to: self)
        bookmarkIcon.setSize(32)
        bookmarkIcon.right(toView: containerView, constant: 16)
        bookmarkIcon.centerVertically(to: containerView)
        
        titleLabel.left(toView: containerView, constant: 16)
        titleLabel.top(toView: containerView, constant: 16)
        titleLabel.relativeRight(toView: bookmarkIcon, constant: 8)
        
        descriptionLabel.left(toView: containerView, constant: 16)
        descriptionLabel.relativeTop(toView: titleLabel, constant: 4)
        descriptionLabel.relativeRight(toView: bookmarkIcon, constant: 0)
        descriptionLabel.bottom(toView: containerView, constant: 16)
    }
}

#Preview {
    BookmarkItemView().asSwiftUI.frame(width: 375, height: 74, alignment: .center)
}
