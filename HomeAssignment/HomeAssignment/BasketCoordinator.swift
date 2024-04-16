//
//  BasketCoordinator.swift
//  HomeAssignment
//
//  Created by Ceboolion on 14/04/2024.
//

import UIKit
import RxSwift

final class BasketCoordinator: NSObject, Coordinator {
    
    //MARK: - PUBLIC PROPERTIES
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .basket }
    weak var parentCoordinator: Coordinator?
    
    private let disposeBag = DisposeBag()
    
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
    
    func start() {
        let controller = BasketController(basketView: BasketView(viewModel: BasketViewModel()))
        navigationController.pushViewController(controller, animated: true)
    }
    
    func setupObservables() {
        bindBasketItems()
    }
    
    func bindBasketItems() {
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
