//
//  FoodModel.swift
//  AnimationDemo
//
//  Created by Fouad Bakour on 04/09/2021.
//

import Foundation
import Moya

struct FoodModel {
    
    // HTTP Request
    struct Request: Encodable { }
    
    // HTTP Response
    struct Response: Decodable {
        let result: Result?
    }

    // MARK: - Result
    struct Result: Decodable {
        let slider: [String]?
        let menu: [Menu]?
    }

    // MARK: - Menu
    struct Menu: Decodable {
        let category: String?
        let categoryId: String?
        let items: [Item]?
    }

    // MARK: - Item
    struct Item: Codable {
        let name: String?
        let ingredients: String?
        let image: String?
        let isSpecial: Bool?
        let highlight: [String]?
        let desc: String?
        let price: String?
        let id: String?
    }
    
    // HTTP Request Module
    enum ServiceModule: TargetType {
        case getFood
        
        var baseURL: URL { Environment.baseURL }
        
        var path: String {
            switch self {
            case .getFood:
                return "/menu"
            }
        }
        
        var method: Moya.Method {
            switch self {
            case .getFood:
                return .get
            }
        }
        
        var sampleData: Data {
            return Data()
        }
        
        var task: Task {
            switch self {
            case .getFood:
                return .requestPlain
            }
        }
        
        var headers: [String : String]? {
            return nil
        }
    }
}
