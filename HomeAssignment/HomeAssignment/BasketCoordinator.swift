//
//  BasketCoordinator.swift
//  HomeAssignment
//
//  Created by Ceboolion on 14/04/2024.
//

import UIKit
import RxSwift

final class BasketCoordinator: NSObject, Coordinator {
    
    //MARK: - PRIVATE PROPERTIES
    private let disposeBag = DisposeBag()
    
    //MARK: - PUBLIC PROPERTIES
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .basket }
    weak var parentCoordinator: Coordinator?
    
    // MARK: - INITIALIZER
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.tabBarItem.image = UIImage(systemName: "basket.fill")
        self.navigationController.tabBarItem.badgeColor = .red
        self.navigationController.tabBarItem.badgeValue = ""
        self.navigationController.tabBarItem.title = "Koszyk"
        start()
        bindBasketItems()
    }
    
    //MARK: - PUBLIC METHODS
    func start() {
        let controller = BasketController(basketView: BasketView(viewModel: BasketViewModel()))
        controller.didSendEventClosure = { [weak self] event in
            switch event {
            case .showPayView:
                self?.showPayView()
            }
        }
        navigationController.pushViewController(controller, animated: true)
    }
    
    //MARK: - PRIVATE METHODS
    private func showPayView() {
        let controller = UIViewController()
        controller.view.backgroundColor = .systemBackground
        navigationController.pushViewController(controller, animated: true)
    }
    
    //MARK: - RX
    private func setupObservables() {
        bindBasketItems()
    }
    
    private func bindBasketItems() {
        ShoppingBasket.shared.basketItems
            .bind { [weak self] basketData in
                basketData.forEach { print("WRC numberOfAvailableProducts: \($0.numberOfAvailableProducts), numberOfChosenProducts: \($0.numberOfChosenProducts)")}
                let productsInBasket = Int(basketData.reduce(0) { $0 + $1.numberOfChosenProducts })
                
                if productsInBasket > 0 {
                    self?.navigationController.tabBarItem.badgeValue = "\(Int(basketData.reduce(0) { $0 + $1.numberOfChosenProducts }))"
                } else {
                    self?.navigationController.tabBarItem.badgeValue = nil
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    
    
}
