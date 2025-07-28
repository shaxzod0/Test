//
//  ViewSpecificController.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//


import UIKit

protocol ViewSpecificController {
    associatedtype RootView: UIView
}

extension ViewSpecificController where Self: UIViewController {
    func view() -> RootView {
        return self.view as! RootView
    }
}
