import UIKit

extension MainCoordinator {
    func makeCoordinator(_ coordinatorType: MainTabBarPage) {
        switch coordinatorType {
        case .start:
            let coordinator = StartCoordinator(navigationController: UINavigationController())
            coordinator.parentCoordinator = self
            childCoordinators.append(coordinator)
        case .basket:
            let coordinator = BasketCoordinator(navigationController: UINavigationController())
            coordinator.parentCoordinator = self
            childCoordinators.append(coordinator)
        }
    }
}
