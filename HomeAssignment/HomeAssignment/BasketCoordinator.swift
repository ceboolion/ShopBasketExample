//
//  BasketCoordinator.swift
//  HomeAssignment
//
//  Created by Ceboolion on 14/04/2024.
//

import UIKit

final class BasketCoordinator: NSObject, Coordinator {
    
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
        self.navigationController.tabBarItem.title = "Koszyk"
        start()
    }
    
    func start() {
        let controller = BasketController()
        navigationController.pushViewController(controller, animated: true)
    }
    
    
    
    
}
