//
//  FoodRepository.swift
//  AnimationDemo
//
//  Created by Fouad Bakour on 04/09/2021.
//

import Foundation
import Moya
import UIComponents

class FoodRepository: FoodRepositoryProtocol {
    
    func getFood(completionHandler: @escaping GenericResultClosure<FoodModel.Response>) {
        let provider = MoyaProvider<FoodModel.ServiceModule>()
        provider.request(.getFood) { results in
            switch results {
            case .success(let response):
                if let parsed = try? response.map(FoodModel.Response.self) {
                    completionHandler(.success(parsed))
                } else {
                    if let parsed = try? response.mapString() {
                        completionHandler(.failure(parsed))
                    } else {
                        completionHandler(.failure("Something went wrong, try again later"))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error.errorDescription ?? "Something went wrong, try again later"))
            }
        }
    }
}
