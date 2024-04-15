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

    
    // MARK: INIT
    init() {
        productsData.accept(getProducts())
        fetchCurrencyData()
            .subscribe(onNext: { [weak self] currencyData in
                self?.currenciesData.accept(currencyData.getCurrencyData())
                // Handle success
            }, onError: { error in
                print("Error: \(error)")
                // Handle error
            })
            .disposed(by: disposeBag)
    }
    
    
    //MARK: - PUBLIC METHODS
    func fetchCurrencyData() -> Observable<CurrencyData> {
        return Observable.create { observer in
            guard let url = Bundle.main.url(forResource: "response", withExtension: "json") else {
                observer.onError(NSError(domain: "HomeAssignment", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found"]))
                return Disposables.create()
            }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let currencyData = try decoder.decode(CurrencyData.self, from: data)
                
                observer.onNext(currencyData)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    //MARK: - PRIVATE METHODS
    private func getProducts() -> [ProductModel] {
        var data: [ProductModel] = []
        for product in ProductType.allCases {
            switch product {
            case .milk:
                data.append(ProductModel(product: .milk, productPrice: 1.30, itemsAvailable: 4, unitOfMeasure: .bottle))
            case .egg:
                data.append(ProductModel(product: .egg, productPrice: 2.10, itemsAvailable: (5 * 12), unitOfMeasure: .dozen))
            case .banana:
                data.append(ProductModel(product: .banana, productPrice: 0.73, itemsAvailable: 4, unitOfMeasure: .kg))
            case .potato:
                data.append(ProductModel(product: .potato, productPrice: 0.95, itemsAvailable: 4, unitOfMeasure: .bag))
            }
        }
        return data
    }
    
}
