//
//  StartCoordinator.swift
//  HomeAssignment
//
//  Created by Ceboolion on 14/04/2024.
//

import UIKit

final class StartCoordinator: NSObject, Coordinator {
    
    //MARK: - PUBLIC PROPERTIES
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .start }
    weak var parentCoordinator: Coordinator?
    
    // MARK: - INITIALIZER
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.tabBarItem.image = UIImage(systemName: "house.fill")
        self.navigationController.tabBarItem.title = "Start"
        start()
    }
    
    func start() {
        let controller = StartController()
        navigationController.pushViewController(controller, animated: true)
        controller.didSendEventClosure = { [weak self] event in
            switch event {
            case .showProduct(let data):
                print("WRC didSendEventClosure showProduct data: \(data)")
                self?.showProductDetails(with: data)
            }
        }
    }
    
    private func showProductDetails(with data: ProductModel) {
        let controller = ProductDetailsViewController()
        controller.setupView(with: data)
        pushController(with: controller)
    }
    
    private func pushController(with controller: UIViewController) {
        navigationController.pushViewController(controller, animated: true)
    }
    
}
