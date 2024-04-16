//
//  NetworkingService.swift
//  HomeAssignment
//
//  Created by Ceboolion on 15/04/2024.
//

import Foundation
import RxSwift

final class NetworkingService {
    
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
    
}
