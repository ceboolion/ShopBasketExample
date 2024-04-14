//
//  MainCoordinator+ChildCreation.swift
//  HomeAssignment
//
//  Created by Ceboolion on 14/04/2024.
//

import UIKit

extension MainCoordinator {
    func makeCoordinator(_ coordinatorType: MainTabBarPage) {
        switch coordinatorType {
        case .start:
            let coordinator = StartCoordinator(navigationController: UINavigationController())
            coordinator.parentCoordinator = self
//            coordinator.finishDelegate = finishDelegate
//            coordinator.onShowTab = { [weak self] tab in
//                self?.tabBarController.selectScreen(tab)
//            }
            childCoordinators.append(coordinator)
        case .basket:
            let coordinator = BasketCoordinator(navigationController: UINavigationController())
            coordinator.parentCoordinator = self
//            coordinator.finishDelegate = finishDelegate
            childCoordinators.append(coordinator)
        }
    }
}
