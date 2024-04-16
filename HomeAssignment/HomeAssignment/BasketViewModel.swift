import Foundation
import RxSwift
import RxCocoa

final class BasketViewModel {
    
    let basketData: BehaviorRelay<[BasketProductsModel]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    
    init() {
        getBasketData()
    }
    
    private func getBasketData() {
        ShoppingBasket.shared.basketItems
            .bind { [weak self] data in
                self?.basketData.accept(data)
            }
            .disposed(by: disposeBag)
    }
    
}
