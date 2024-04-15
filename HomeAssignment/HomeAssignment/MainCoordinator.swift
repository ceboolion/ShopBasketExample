import UIKit

enum MainTabBarPage {
    case start
    case basket

    init?(index: Int) {
        switch index {
        case 0:
            self = .start
        case 1:
            self = .basket
        default:
            return nil
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .start:
            return 0
        case .basket:
            return 1
        }
    }
}

final class MainCoordinator: NSObject, Coordinator {
    
    //MARK: - PUBLIC PROPERTIES
    var type: CoordinatorType { .mainTab }
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    //MARK: - INITIALIZERS
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    //MARK: - PUBLIC METHODS
    func start() {
        showHome()
    }
    
    func showHome() {
        tabBarController = makeTabBar()
        
        makeCoordinator(.start)
        makeCoordinator(.basket)
        
        tabBarController.viewControllers = childCoordinators.map(\.navigationController)
        tabBarController.selectScreen(.start)
        
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(tabBarController, animated: true)
    }
}
