import Foundation
import RxSwift
import RxCocoa

final class BasketViewModel: BasketManager {
    
    //MARK: - PUBLIC PROPERTIES
    let basketData: BehaviorRelay<[BasketProductsModel]> = BehaviorRelay(value: [])
    
    // MARK: - INIT
    override init() {
        super.init()
        getBasketData()
    }
    
    //MARK: - PRIVATE METHODS
    private func getBasketData() {
        ShoppingBasket.shared.basketItems
            .bind { [weak self] data in
                self?.basketData.accept(data)
            }
            .disposed(by: disposeBag)
    }
    
    
}
