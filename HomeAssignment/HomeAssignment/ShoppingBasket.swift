import Foundation
import RxSwift
import RxCocoa

class ShoppingBasket {
    
    //MARK: - PUBLIC PROPERTIES
    let basketItems: BehaviorRelay<[BasketProductsModel]> = BehaviorRelay(value: [])
    static let shared = ShoppingBasket()
    
    // MARK: - INIT
    private init() {}
    
    //MARK: - PUBLIC METHODS
    func addProduct(products: [BasketProductsModel]) {
        basketItems.accept(products)
    }
    
    func removeProduct(products: [BasketProductsModel]) {
        basketItems.accept(products)
        removeProductIfNeeded()
    }
    
    func deleteBasketProduct(products: [BasketProductsModel]) {
        basketItems.accept(products)
    }
    
    //MARK: - PRIVATE METHODS
    private func removeProductIfNeeded() {
        var products = basketItems.value
        products.forEach { product in
            if product.numberOfChosenProducts == 0 {
                guard let index = products.firstIndex(where: {$0.id == product.id}) else { return }
                products.remove(at: index)
                basketItems.accept(products)
            }
        }
    }
    
    
}
