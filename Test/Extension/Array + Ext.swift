//
//  Array + Ext.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

extension Array {
    subscript(safe index: Int) -> Element? { indices.contains(index) ? self[index] : nil }
}
