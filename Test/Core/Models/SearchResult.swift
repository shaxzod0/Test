//
//  SearchResult.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 28/07/25.
//

import Foundation
import CoreLocation

struct SearchResult: Codable, Equatable, BookmarksItemProvider {
    let id: String
    let name: String
    let address: String
    let distance: String
    let latitude: Double
    let longitude: Double
    let category: String?
    let rating: Double?
    let isOpen: Bool?
    
    var title: String {
        return name
    }
    
    var description: String {
        return address
    }
    
    func toLocation() -> SearchResult {
        return SearchResult(
            id: id,
            name: name,
            address: address,
            distance: distance,
            latitude: latitude,
            longitude: longitude,
            category: category,
            rating: rating,
            isOpen: isOpen
        )
    }
}
