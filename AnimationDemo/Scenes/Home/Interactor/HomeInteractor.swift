//
//  HomeInteractor.swift
//  AnimationDemo
//
//  Created by Fouad Bakour on 04/09/2021.
//

import UIKit
import RxSwift
import UIComponents

class HomeInteractor {
    
    /// Interactor -> Presenter
    let responseSubject = PublishSubject<FoodModel.Response>()
    
    /// RX DisposeBag
    let disposeBag = DisposeBag()
    
    /// Repositories
    let foodRepositoryProtocol: FoodRepositoryProtocol
    init(foodRepositoryProtocol: FoodRepositoryProtocol) {
        self.foodRepositoryProtocol = foodRepositoryProtocol
    }
}

// MARK: - Internal
extension HomeInteractor {
    private func fetchData() {
        foodRepositoryProtocol.getFood { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.responseSubject.onNext(data)
            case .failure(let error):
                self.responseSubject.onError(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: error]))
            }
        }
    }
}

// MARK: - Protocols
extension HomeInteractor: HomePresenterToInteractor {
    func subscribeToShouldFetchData(_ subject: PublishSubject<Void>) {
        subject.subscribe { [weak self] () in
            guard let self = self else { return }
            self.fetchData()
        } onCompleted: {}
        .disposed(by: disposeBag)
    }
}
