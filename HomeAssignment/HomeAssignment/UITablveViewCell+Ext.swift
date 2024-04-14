//
//  UITablveViewCell+Ext.swift
//  HomeAssignment
//
//  Created by Ceboolion on 14/04/2024.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
