//
//  BookmarksRootView.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit

final class BookmarksRootView: UIView {
    
    // MARK: - OUTLETS
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookmarkItemCell.self, forCellReuseIdentifier: BookmarkItemCell.description())
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    // MARK: - DEPENDENCIES
    
    private let viewModel: BookmarksViewModel
    
    // MARK: - LIFECYCLE
    
    init(viewModel: BookmarksViewModel) {
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
        bindViewModel()
    }
    
    private func setupSubviews() {
        backgroundColor = .background
        addSubview(tableView)
    }
    
    private func configureConstraints() {
        tableView.fillSides(to: self)
    }
    
    private func bindViewModel() {
        viewModel.bookmarks.bindAndFire { [weak self] _ in
            guard let self else { return }
            tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension BookmarksRootView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookmarks.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkItemCell.description(), for: indexPath) as? BookmarkItemCell else {
            return UITableViewCell()
        }
        
        let bookmark = viewModel.bookmarks.value[indexPath.row]
        cell.configure(with: bookmark)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectBookmark(at: indexPath.row)
    }
}
