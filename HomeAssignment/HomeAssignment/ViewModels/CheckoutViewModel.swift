import Foundation
import RxSwift
import RxCocoa

final class CheckoutViewModel {
    
    //MARK: - PUBLIC PROPERTIES
    let basketData: BehaviorRelay<[BasketProductsModel]> = BehaviorRelay(value: [])
    var currencyData: [CurrencyModel] = []
    let disposeBag = DisposeBag()
    
    //MARK: - PRIVATE PROPERTIES
    private var networkingService: NetworkingService?
    
    // MARK: - INIT
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
        getBasketData()
        getCurrenciesData()
    }
    
    //MARK: - PRIVATE METHODS
    private func getBasketData() {
        ShoppingBasket.shared.basketItems
            .bind { [weak self] data in
                self?.basketData.accept(data)
            }
            .disposed(by: disposeBag)
    }
    
    private func getCurrenciesData() {
        networkingService?.fetchCurrencyData()
            .subscribe(onNext: { [weak self] data in
                self?.currencyData = data.getCurrencyData()
//                var currencyData = data.getCurrencyData()
//                currencyData.insert(CurrencyModel(currency: "USD", currencyData: 1), at: 0)
//                self?.currencyData = currencyData
            }, onError: { error in
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
}
