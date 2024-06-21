import UIKit

extension UIStackView {
    func addSubviews(views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
