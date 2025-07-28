//  
//  BookmarksRepository.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import Foundation

class BookmarksRepository: BookmarksRepositoryProtocol {
    var manager: any FavoritesServiceProtocol
    
    init(manager: any FavoritesServiceProtocol) {
        self.manager = manager
    }
}
