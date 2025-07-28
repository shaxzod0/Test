//
//  FavoritesService.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import Foundation
import CoreLocation

protocol FavoritesServiceProtocol {
    func getFavorites() -> [SearchResult]
    func addToFavorites(_ location: SearchResult)
    func removeFromFavorites(_ locationId: String)
    func isFavorite(_ locationId: String) -> Bool
}

class FavoritesService: FavoritesServiceProtocol {
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "favorites_locations"
    
    func getFavorites() -> [SearchResult] {
        guard let data = userDefaults.data(forKey: favoritesKey),
              let favorites = try? JSONDecoder().decode([SearchResult].self, from: data) else {
            return []
        }
        
        return favorites.map { $0.toLocation() }
    }
    
    func addToFavorites(_ location: SearchResult) {
        var favorites = getFavorites()
        if !favorites.contains(where: { $0.id == location.id }) {
            let updatedLocation = location
            favorites.append(updatedLocation)
            saveFavorites(favorites)
        }
    }
    
    func removeFromFavorites(_ locationId: String) {
        let favorites = getFavorites().filter { $0.id != locationId }
        saveFavorites(favorites)
    }
    
    func isFavorite(_ locationId: String) -> Bool {
        return getFavorites().contains { $0.id == locationId }
    }
    
    private func saveFavorites(_ favorites: [SearchResult]) {
        if let data = try? JSONEncoder().encode(favorites) {
            userDefaults.set(data, forKey: favoritesKey)
        }
    }
}
