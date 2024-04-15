//
//  UIStackView+Ext.swift
//  HomeAssignment
//
//  Created by Ceboolion on 15/04/2024.
//

import UIKit

extension UIStackView {
    func addSubviews(views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
