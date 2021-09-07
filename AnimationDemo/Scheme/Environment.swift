//
//  Environment.swift
//  AnimationDemo
//
//  Created by Fouad Bakour on 07/09/2021.
//

import Foundation
enum Environment {
    
    static func value(for key: Environment.Key) throws -> String {
        guard let configuration = Bundle.main.object(forInfoDictionaryKey: Key.configuration.rawValue) as? [String: Any],
              let value = configuration[key.rawValue] as? String
        else {
            throw Error.missingKey
        }
        
        return value.replacingOccurrences(of: "\\", with: "")
    }
    
    static let baseURL = URL(string: (try? value(for: .baseURL)) ?? "") ?? URL(fileURLWithPath: "")
}

extension Environment {
    enum Key: String {
        case configuration = "Configuration"
        case baseURL = "API_HOST"
    }
    
    enum Error: Swift.Error {
        case missingKey
    }
}
