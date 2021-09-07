//
//  HomePresenter.swift
//  AnimationDemo
//
//  Created by Fouad Bakour on 04/09/2021.
//

import UIKit
import RxSwift

class HomePresenter {
    
    /// Presenter -> Interactor
    let startFetchingSubject = PublishSubject<Void>()
    
    /// Presenter -> View
    let displayResultsSubject = PublishSubject<[HomeUIModel.Section]>()
    let setDefaultCategorySubject = PublishSubject<String>()
    let displayFilterSubject = PublishSubject<[HomeUIModel.Section]>()
    let isLoadingSubject = PublishSubject<Bool>()
    
    /// Interactor
    let interactor = HomeInteractor(foodRepositoryProtocol: FoodRepository())
    
    /// RX DisposeBag
    let disposeBag = DisposeBag()
    
    /// Private variables
    private var response: FoodModel.Response?
    
    init() {
        response = nil
        interactor.subscribeToShouldFetchData(startFetchingSubject)
        subscribeToFetchDidFinish(interactor.responseSubject)
    }
}

// MARK: - Internal
extension HomePresenter {
 
    private func viewDidLoad() {
        startFetchingSubject.onNext(())
        isLoadingSubject.onNext(true)
    }
    
    private func loadDataFinished(response: FoodModel.Response?,
                                  selectedCategory: String) {
        isLoadingSubject.onNext(false)
        
        // Guard it
        guard let response = response else { return }
        
        // Map and display
        let mapped = map(response: response, selectedCategory: selectedCategory)
        displayResultsSubject.onNext(mapped)
    }
    
    private func loadDataFailed(error: Error) {
        isLoadingSubject.onNext(false)
        displayResultsSubject.onError(error)
    }
}

// MARK: - Protocols
extension HomePresenter: HomeControllerToPresenter {
    func subscribeToViewIsFiltering(_ subject: PublishSubject<String>) {
        subject.subscribe { [weak self] (categoryId) in
            guard let self = self else { return }
            self.setDefaultCategorySubject.onNext(categoryId)
            self.loadDataFinished(response: self.response,
                                  selectedCategory: categoryId)
        } onCompleted: {}
        .disposed(by: disposeBag)
    }
    
    func subscribeToViewDidLoad(_ subject: PublishSubject<Void>) {
        subject.subscribe { [weak self] () in
            guard let self = self else { return }
            self.viewDidLoad()
        } onCompleted: {}
        .disposed(by: disposeBag)
    }
}

// MARK: - Protocols
extension HomePresenter: HomeInteractorToPresenter {
    
    func subscribeToFetchDidFinish(_ subject: PublishSubject<FoodModel.Response>) {
        subject.subscribe { [weak self] (response) in
            guard let self = self else { return }
            
            // Store response
            self.response = response
            
            // Make the first category selected by default
            let defaultCategory = response.result?.menu?.first?.categoryId ?? ""
            self.setDefaultCategorySubject.onNext(defaultCategory)
            self.loadDataFinished(response: response,
                                  selectedCategory: defaultCategory)
            
        } onError: { [weak self] (error) in
            guard let self = self else { return }
            self.loadDataFailed(error: error)
        } onCompleted: {}
        .disposed(by: disposeBag)
    }
}

// MARK: - Map to UI
extension HomePresenter {
    
    private func map(response: FoodModel.Response, selectedCategory: String) -> [HomeUIModel.Section] {
        guard let result = response.result,
              let menu = result.menu,
              let slider = result.slider else { return [] }
        
        let section1 = HomeUIModel.Section(type: .slider,
                                           numberOfRows: 1,
                                           sliderImages: slider,
                                           segments: [],
                                           foodItems: [])
        
        let section2 = HomeUIModel.Section(type: .segment,
                                           numberOfRows: 1,
                                           sliderImages: [],
                                           segments: menu.map({HomeUIModel.Segment(name: $0.category ?? "",
                                                                                   id: $0.categoryId ?? "")}),
                                           foodItems: [])
        
        let selectedCategoryItems = menu.first(where: { $0.categoryId == selectedCategory })
        
        let section3 = HomeUIModel.Section(type: .foodItems,
                                           numberOfRows: selectedCategoryItems?.items?.count ?? 0,
                                           sliderImages: [],
                                           segments: [],
                                           foodItems: selectedCategoryItems?.items.map({ mapMenuItems(items: $0)} ) ?? [])
        

        return [section1, section2, section3]
        
    }
    
    private func mapMenuItems(items: [FoodModel.Item]) -> [MenuItemUIModel] {
        let mapped = items.map { item in
            return MenuItemUIModel(id: item.id,
                                   name: item.name,
                                   desc: item.desc,
                                   imageURL: item.image,
                                   price: item.price,
                                   ingredients: item.ingredients,
                                   isSpecial: item.isSpecial,
                                   highlight: item.highlight)
        }
        return mapped
        
    }
}
