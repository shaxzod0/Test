//  
//  MapRepositoryProtocol.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import Foundation
import YandexMapsMobile

protocol MapRepositoryProtocol {
    func searchPlaces(query: String, userLocation: YMKPoint?, completion: @escaping (Result<[SearchResult], Error>) -> Void)
}
