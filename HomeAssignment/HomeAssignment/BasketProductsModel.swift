//
//  BasketProductsModel.swift
//  HomeAssignment
//
//  Created by Ceboolion on 16/04/2024.
//

import Foundation

struct BasketProductsModel: ProductModelProtocol {
    var id: UUID
    var product: ProductType
    var productPrice: Double
    var unitOfMeasure: UnitsOfMeasure
    var numberOfChosenProducts: Double
    var numberOfAvailableProducts: Int
}
