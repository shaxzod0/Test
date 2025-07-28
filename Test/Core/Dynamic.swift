//
//  Dynamic.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//


import UIKit

public final class Dynamic<T> {
    
    public typealias Listener = (T) -> Void
    public typealias UpdateListener = () -> Void
    
    /// Listener storage object
    private var listener: Listener?
    private var updateListener: UpdateListener?
    
    public var value: T {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
                self.updateListener?()
            }
        }
    }
    
    public init(_ value: T) {
        self.value = value
    }
    
    /// Added listener will be called, whenever the value changes
    public func bind(_ listener: @escaping Listener) {
        self.listener = listener
    }
    
    /// Added listener will be called, whenever the value changes and immediately after closure set
    public func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    public func editingDidChange(_ updateListener: @escaping UpdateListener) {
        self.updateListener = updateListener
    }
    
}
