//
//  BookmarksItemProvider.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import Foundation

protocol BookmarksItemProvider {
    var title: String { get }
    var description: String { get }
    var id: String { get }
}
