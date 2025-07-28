//  
//  PlaceDetailsRepository.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import Foundation

class PlaceDetailsRepository: PlaceDetailsRepositoryProtocol{
    var favoriteService: any FavoritesServiceProtocol
    
    init(favoriteService: any FavoritesServiceProtocol) {
        self.favoriteService = favoriteService
    }
}
