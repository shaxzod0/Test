
//
//  BookmarkItemCell.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit

final class BookmarkItemCell: UITableViewCell {
    
    private lazy var bookmarkItemView: BookmarkItemView = .init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: BookmarksItemProvider) {
        bookmarkItemView.configure(with: model)
    }
}

private extension BookmarkItemCell {
    func initViews() {
        selectionStyle = .none
        backgroundColor = .clear
        bookmarkItemView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews() {
        contentView.addSubview(bookmarkItemView)
    }
    
    func setupConstraints() {
        bookmarkItemView.top(toView: contentView, constant: 8)
        bookmarkItemView.bottom(toView: contentView, constant: 8)
        bookmarkItemView.left(toView: contentView, constant: 16)
        bookmarkItemView.right(toView: contentView, constant: 16)
    }
}
