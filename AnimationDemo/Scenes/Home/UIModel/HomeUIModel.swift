//
//  HomeUIModel.swift
//  AnimationDemo
//
//  Created by Fouad Bakour on 05/09/2021.
//

import Foundation

struct HomeUIModel {
    
    struct Segment {
        let name: String
        let id: String
    }
    
    enum SectionType {
        case slider
        case segment
        case foodItems
    }
    
    struct Section {
        let type: SectionType
        let numberOfRows: Int
        let sliderImages: [String]
        let segments: [Segment]
        let foodItems: [MenuItemUIModel]
    }
}
