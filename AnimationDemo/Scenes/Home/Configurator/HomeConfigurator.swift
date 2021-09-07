//
//  HomeConfigurator.swift
//  AnimationDemo
//
//  Created by Fouad Bakour on 04/09/2021.
//

import UIKit
import UIComponents
import RxSwift


final class HomeConfigurator {
    
    // MARK: Configuration
    class func viewController() -> HomeViewController {
        let viewController = HomeViewController.instantiate(from: "Home")
        return viewController
    }
}

// Controller -> Presenter
protocol HomeControllerToPresenter {
    func subscribeToViewDidLoad(_ subject: PublishSubject<Void>)
    func subscribeToViewIsFiltering(_ subject: PublishSubject<String>)
}

// Presenter -> Interactor
protocol HomePresenterToInteractor {
    func subscribeToShouldFetchData(_ subject: PublishSubject<Void>)
}

// Interactor -> Presenter
protocol HomeInteractorToPresenter {
    func subscribeToFetchDidFinish(_ subject: PublishSubject<FoodModel.Response>)
}

// Presenter -> Controller
protocol HomePresenterToController {
    func subscribeToHandleFetchedData(_ subject: PublishSubject<[HomeUIModel.Section]>)
    func subscribeToHandleFilteredData(_ subject: PublishSubject<[HomeUIModel.Section]>)
    func subscribeToIsLoading(_ subject: PublishSubject<Bool>)
    func subscribeToDefaultCategory(_ subject: PublishSubject<String>)
}

// Presenter -> Router
protocol HomePresenterToRouter {
    func routeToSomewhere()
}
