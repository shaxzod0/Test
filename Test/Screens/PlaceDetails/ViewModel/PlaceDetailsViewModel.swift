//  
//  PlaceDetailsViewModel.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit
import Foundation

struct PlaceDetailsViewModelActions {
    
}

class PlaceDetailsViewModel {

    private let repository: PlaceDetailsRepositoryProtocol?
    private let actions: PlaceDetailsViewModelActions
    let placeDetails: SearchResult
    
    var savingState: Dynamic<Bool> = Dynamic(false)
    
    init(
        repository: PlaceDetailsRepositoryProtocol,
        actions: PlaceDetailsViewModelActions,
        placeDetails: SearchResult
    ) {
        self.repository = repository
        self.actions = actions
        self.placeDetails = placeDetails
    }
    
    func addToFavorites() {
        repository?.favoriteService.addToFavorites(placeDetails)
        savingState.value = true
        NotificationCenter.default.post(name: .updateBookmarks, object: nil)
    }
}
