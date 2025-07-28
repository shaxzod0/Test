//
//  ViewModelState.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//



import Foundation

public enum ViewModelState: Int {
    case initializing, ready, loading, loadComplete
    
    public var isAvailableForRequest: Bool {
        switch self {
        case .ready, .loadComplete:
            return true
        default:
            return false
        }
    }
}


