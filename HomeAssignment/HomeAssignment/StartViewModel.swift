//
//  StartViewModel.swift
//  HomeAssignment
//
//  Created by Ceboolion on 14/04/2024.
//

import Foundation
import RxSwift
import RxCocoa

final class StartViewModel {
    
    //MARK: - PUBLIC PROPERTIES
    let productsData: BehaviorRelay<[ProductModel]> = BehaviorRelay(value: [])
    let currenciesData: BehaviorRelay<[CurrencyModel]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    
    //MARK: - PRIVATE PROPERTIES
    private var networkingService: NetworkingService?
    
    // MARK: INIT
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
        productsData.accept(getProducts())
        getCurrenciesData()
    }
    
    
    //MARK: - PUBLIC METHODS
    func getCurrenciesData() {
        networkingService?.fetchCurrencyData()
            .subscribe(onNext: { [weak self] currencyData in
                self?.currenciesData.accept(currencyData.getCurrencyData())
            }, onError: { error in
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    //MARK: - PRIVATE METHODS
    private func getProducts() -> [ProductModel] {
        var data: [ProductModel] = []
        for product in ProductType.allCases {
            switch product {
            case .milk:
                data.append(ProductModel(product: .milk, productPrice: 1.30, itemsAvailable: 4, unitOfMeasure: .bottle))
            case .egg:
                data.append(ProductModel(product: .egg, productPrice: 2.10, itemsAvailable: 60, unitOfMeasure: .dozen))
            case .banana:
                data.append(ProductModel(product: .banana, productPrice: 0.73, itemsAvailable: 4, unitOfMeasure: .kg))
            case .potato:
                data.append(ProductModel(product: .potato, productPrice: 0.95, itemsAvailable: 4, unitOfMeasure: .bag))
            case .none:
                break
            }
        }
        return data
    }
    
}
