//
//  ProductModel.swift
//  HomeAssignment
//
//  Created by Ceboolion on 14/04/2024.
//

import Foundation

struct ProductModel {
    let id = UUID()
    let product: ProductType
    let productPrice: Double
    let itemsAvailable: Int
    let unitOfMeasure: UnitsOfMeasure
}
