//
//  HomeViewController.swift
//  AnimationDemo
//
//  Created by Fouad Bakour on 04/09/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import UIComponents

final class HomeViewController: UIViewController {
    
    // MARK: - Props
    var sections: [HomeUIModel.Section] = [] {
        didSet {
            self.tableView.reloadData()
            self.cartButton.isHidden = sections.count == 0
            if !self.headerView.hasContent() {
                let sliderImages = self.sections.first(where: { $0.type == .slider })?.sliderImages ?? []
                let segmentTabs = self.sections.first(where: { $0.type == .segment })?.segments ?? []
                let sliderImagesItems = sliderImages.map({AppSlideShow.Items(imageUrl: $0)})
                let segmentTabsItems = segmentTabs.map({AppSegment.Items(title: $0.name,
                                                                         id: $0.id,
                                                                         defaultStyle: .headerOneLight,
                                                                         selectedStyle: .headerOne)})
                self.headerView.configure(slider: .init(items: sliderImagesItems),
                                          segment: .init(items: segmentTabsItems,
                                                         selectedId: self.defaultCategoryId))
                self.headerView.delegate = self
            }
        }
    }
    var defaultCategoryId: String = ""
    var headerView: AppParallaxHeaderView!
    
    /// View -> Presenter
    let viewDidLoadSubject = PublishSubject<Void>()
    let shouldFilterSubject = PublishSubject<String>()
    
    /// Presenter
    let presenter = HomePresenter()
    
    /// RX DisposeBag
    let disposeBag = DisposeBag()
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableViewCenterX: NSLayoutConstraint!
    @IBOutlet weak var cartButton: AppCartButton! {
        didSet {
            self.cartButton.isHidden = true
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewDidLoadSubject.onNext(())
    }
    
    // MARK: - Configure View
    func configureView() {
        
        // Cart button
        cartButton.configure(for: .init(itemsCount: 0))
        
        // Presenter subscribe
        presenter.subscribeToViewDidLoad(viewDidLoadSubject)
        presenter.subscribeToViewIsFiltering(shouldFilterSubject)
        
        // View subscribe
        subscribeToHandleFetchedData(presenter.displayResultsSubject)
        subscribeToHandleFilteredData(presenter.displayFilterSubject)
        subscribeToIsLoading(presenter.isLoadingSubject)
        subscribeToDefaultCategory(presenter.setDefaultCategorySubject)
        
        // Table view
        configureTableView()
        
        // Configure Animations
        configureAnimations()
    }
}

// MARK: - Configure table view
extension HomeViewController {
    
    @objc func refreshData() {
        viewDidLoadSubject.onNext(())
    }
    
    func configureTableView() {
        headerView = AppParallaxHeaderView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: tableView.frame.height / 1.5))
        tableView.register(SlideShowTableViewCell.self)
        tableView.register(ProductTableViewCell.self)
        tableView.register(SegmentTableViewCell.self)
        tableView.setRefreshControl(target: self, action: #selector(refreshData))
        tableView.estimatedRowHeight = 150
        tableView.separatorStyle = .none
        self.tableView.tableHeaderView = headerView
    }
}

// MARK: - Result handling
extension HomeViewController {
    private func handleResults(_ subject: PublishSubject<[HomeUIModel.Section]>) {
        subject.subscribe { [weak self] data in
            guard let self = self else { return }
            self.sections = data
        } onError: { [weak self] (error) in
            guard let self = self else { return }
            self.showError(message: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    private func showError(message: String) {
        AlertBuilder(title: "Oops!",
                     message: message,
                     preferredStyle: .alert)
            .addAction(title: "Ok", style: .cancel, handler: nil)
            .build()
            .show()
    }
}

// MARK: - Protocols
extension HomeViewController: HomePresenterToController {
    
    func subscribeToDefaultCategory(_ subject: PublishSubject<String>) {
        subject.subscribe { [weak self] (defaultCategoryId) in
            guard let self = self, let defaultCategoryId = defaultCategoryId.element else { return }
            self.defaultCategoryId = defaultCategoryId
        }.disposed(by: disposeBag)
    }
    
    func subscribeToIsLoading(_ subject: PublishSubject<Bool>) {
        subject.subscribe { [weak self] (isLoading) in
            guard let self = self, let isLoading = isLoading.element else { return }
            isLoading ? self.tableView.beginRefreshing() : self.tableView.endRefreshing()
        }.disposed(by: disposeBag)
    }
    
    func subscribeToHandleFilteredData(_ subject: PublishSubject<[HomeUIModel.Section]>) {
        handleResults(subject)
    }
    
    func subscribeToHandleFetchedData(_ subject: PublishSubject<[HomeUIModel.Section]>) {
        handleResults(subject)
    }
}

// MARK: - AppSegmentDelegate
extension HomeViewController: AppParallaxHeaderViewDelegate {
    func didSelectItem(id: String) {
        shouldFilterSubject.onNext(id)
    }
}
