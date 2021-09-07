//
//  MenuItemUIModel.swift
//  AnimationDemo
//
//  Created by Fouad Bakour on 05/09/2021.
//

import Foundation

/// This is a shared
struct MenuItemUIModel {
    let id: String?
    let name: String?
    let desc: String?
    let imageURL: String?
    let price: String?
    let ingredients: String?
    let isSpecial: Bool?
    let highlight: [String]?
    
    // Computed
    var description: NSMutableAttributedString {
        guard let highlightedWords = highlight else {
            return NSMutableAttributedString(string: ingredients ?? "").set(style: .productListDesc)
        }
        if highlightedWords.count > 0 {
            return NSMutableAttributedString(string: ingredients ?? "").set(style: .productListDesc).set(style: .productListDescHighlighted, for: highlightedWords.first, allOccurences: false)
        } else {
            return NSMutableAttributedString(string: ingredients ?? "").set(style: .productListDesc)
        }
    }
    
    var attributedTitle: NSMutableAttributedString {
        if isSpecial ?? false {
            return NSMutableAttributedString(string: "\(name ?? "") •").set(style: .productListTitle).set(style: .bulletPoint, for: "•", allOccurences: false)
        }
        return NSMutableAttributedString(string: name ?? "").set(style: .productListTitle)
    }
}
