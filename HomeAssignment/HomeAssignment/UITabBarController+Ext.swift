import UIKit

extension UITabBarController {
    func selectScreen(_ coordinatorType: MainTabBarPage) {
        selectedIndex = coordinatorType.pageOrderNumber()
    }
}
