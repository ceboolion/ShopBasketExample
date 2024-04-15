//
//  ProductType.swift
//  HomeAssignment
//
//  Created by Ceboolion on 14/04/2024.
//

import UIKit

enum ProductType: CaseIterable {
    case milk
    case egg
    case banana
    case potato
    
    var image: ImageResource {
        switch self {
        case .milk:
            return .milk
        case .egg:
            return .eggs
        case .banana:
            return .bananas
        case .potato:
            return .potatos
        }
    }
    
    var productTitle: String {
        switch self {
        case .milk:
            return "Najlepsze mleko na świecie"
        case .egg:
            return "Najlepsze jajka na świecie"
        case .banana:
            return "Najlepsze banany na świecie"
        case .potato:
            return "Najlepsze ziemniaki na świecie"
        }
    }
}
