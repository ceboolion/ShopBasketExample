//
//  UnitsOfMeasure.swift
//  HomeAssignment
//
//  Created by Ceboolion on 15/04/2024.
//

import Foundation

enum UnitsOfMeasure {
    case bag, dozen, bottle, kg, none
    
    var name: String {
        switch self {
        case .bag:
            return " / opakowanie"
        case .dozen:
            return " / 12 szt."
        case .bottle:
            return " / butelkę"
        case .kg:
            return " / kilogram"
        case .none:
            return " / - "
        }
    }
}
