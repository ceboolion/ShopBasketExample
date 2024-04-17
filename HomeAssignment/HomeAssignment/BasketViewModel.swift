import Foundation
import RxSwift
import RxCocoa

final class BasketViewModel: BasketManager {
    
    //MARK: - PUBLIC PROPERTIES
    let basketData: BehaviorRelay<[BasketProductsModel]> = BehaviorRelay(value: [])
    var currencyData: CurrencyData?
    
    //MARK: - PRIVATE PROPERTIES
    private var networkingService: NetworkingService?
    
    // MARK: - INIT
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
        super.init()
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
                self?.currencyData = data
            }, onError: { error in
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    
}
