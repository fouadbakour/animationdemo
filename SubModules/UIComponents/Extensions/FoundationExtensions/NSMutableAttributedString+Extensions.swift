//
//  File.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import Foundation

public extension NSMutableAttributedString {
    /// Set the style of an attributed string
    /// - Parameters:
    ///   - style: ABLabelStyle to be used
    ///   - value: Optional, will only add style to this string, else to all string
    ///   - allOccurences: Optional, will define if all occurences will be updated, else only first
    /// - Returns: self
    @discardableResult
    func set(style: LabelStyles, for value: String? = nil, allOccurences: Bool = false) -> Self {
        let attributes = [
            NSAttributedString.Key.foregroundColor: style.textColor,
            NSAttributedString.Key.font: style.font
        ]
        set(attributes: attributes, for: value, allOccurences: allOccurences)
        return self
    }
    
    /// Build an NSMutableAttributedString from different params
    /// - Parameter strings: text and corresponding ABLabelStyle
    /// - Returns: self
    static func buildAttributedString(_ strings: (text: String, style: LabelStyles)...) -> NSMutableAttributedString {
        return strings.reduce(NSMutableAttributedString(), {
            $0.append(NSMutableAttributedString(string: $1.text).set(style: $1.style))
            return $0
        })
    }
    
    /// Set any attribute for an attributed string
    ///
    /// - Parameters:
    ///   - attributes: Any [NSAttributedString.Key: Any] attribute
    ///   - value: Optional, will only add font to that string, else to all string
    ///   - allOccurences: Optional, will define if all occurences will be updated or only first
     private func set(attributes: [NSAttributedString.Key: Any], for value: String? = nil, allOccurences: Bool) {
        if let value = value, value != string {
            let ranges = rangesForValue(value, allOccurences)
            set(attributes: attributes, for: ranges)
        } else {
            let ranges = [NSRange(location: 0, length: string.count)]
            set(attributes: attributes, for: ranges)
        }
    }
    
    /// Get the array of ranges of a string inside the NSMutableAttributedString's striinsng
    ///
    /// - Parameter value: string to be used as pattern
    /// - Returns: array of ranges
    private func rangesForValue(_ value: String, _ allOccurences: Bool) -> [NSRange] {
        let escapedString = escapeString(value)
        if let regex = try? NSRegularExpression(pattern: escapedString, options: []) {
            let rangeOfSearch = NSRange(location: 0, length: string.count)
            let ranges = regex.matches(in: string, options: [], range: rangeOfSearch).map({ $0.range })
            if allOccurences {
                return ranges
            }
            if let firstRange = ranges.first {
                return [firstRange]
            }
        }
        return []
    }
    
    private func escapeString(_ value: String) -> String {
        return value.replacingOccurrences(of: "*", with: "\\*")
    }
    
    private func set(attributes: [NSAttributedString.Key: Any], for ranges: [NSRange]) {
        ranges.forEach({
            self.addAttributes(attributes, range: $0)
        })
    }
}
