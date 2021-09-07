//
//  FoodRepositoryProtocol.swift
//  AnimationDemo
//
//  Created by Fouad Bakour on 04/09/2021.
//
import UIComponents

protocol FoodRepositoryProtocol {
    func getFood(completionHandler: @escaping GenericResultClosure<FoodModel.Response>)
}
