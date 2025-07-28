//
//  BookmarksViewModel.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit
import Foundation

struct BookmarksViewModelActions {
    
}

class BookmarksViewModel: DefaultViewModel {
    
    // MARK: - Properties
    private let favoritesService: FavoritesServiceProtocol
    private let actions: BookmarksViewModelActions
    // MARK: - Observable Properties
    let bookmarks = Dynamic<[SearchResult]>([])
    
    // MARK: - Initialization
    init(
        favoritesService: FavoritesServiceProtocol,
        actions: BookmarksViewModelActions
    ) {
        self.favoritesService = favoritesService
        self.actions = actions
        super.init()
        loadBookmarks()
    }
    
    // MARK: - Public Methods
    func loadBookmarks() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            bookmarks.value = favoritesService.getFavorites()
        }
    }
}
