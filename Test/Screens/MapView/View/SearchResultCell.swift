//
//  SearchResultCell.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 28/07/25.
//

import UIKit

final class SearchResultCell: UITableViewCell {
    static let identifier = "SearchResultCell"
    private lazy var placeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .icLocation
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var placeNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var placeAddressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
        
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: SearchResult) {
        placeNameLabel.text = model.name
        placeAddressLabel.text = model.address
        distanceLabel.text = model.distance
    }
}

private extension SearchResultCell {
    func initViews() {
        
    }
    func addSubviews() {
        contentView.addSubview(placeIcon)
        contentView.addSubview(placeNameLabel)
        contentView.addSubview(placeAddressLabel)
        contentView.addSubview(distanceLabel)
    }
    func setupConstraints() {
        placeIcon.setSize(32)
        placeIcon.left(toView: contentView, constant: 16)
        placeIcon.top(toView: contentView, constant: 16)
        
        distanceLabel.right(toView: contentView, constant: 16)
        distanceLabel.top(toView: contentView, constant: 16)
        
        placeNameLabel.relativeLeft(toView: placeIcon, constant: 8)
        placeNameLabel.top(toView: contentView, constant: 16)
        placeNameLabel.relativeRight(toView: distanceLabel, constant: 8)
        
        placeAddressLabel.relativeLeft(toView: placeIcon, constant: 8)
        placeAddressLabel.relativeTop(toView: placeNameLabel, constant: 4)
        placeAddressLabel.relativeRight(toView: distanceLabel, constant: 16)
        placeAddressLabel.bottom(toView: contentView, constant: 16)
    }
}
