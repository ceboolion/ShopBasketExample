import UIKit

extension MainCoordinator {
    func makeTabBar() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.tintColor = .black
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)], for: .selected)
        return tabBarController
    }
}
