import Foundation
import RxSwift
import RxCocoa

class ShoppingBasket {
    
    let basketItems: BehaviorRelay<[BasketProductsModel]> = BehaviorRelay(value: [])
    static let shared = ShoppingBasket()
    
    private init() {}
    
    func updateProductsBasket(_ type: BasketUpdateType, product: BasketProductsModel) {
        type == .add ? appendToArray(product: product) : removeFromArray(product: product)
    }
    
    private func appendToArray(product: BasketProductsModel) {
        var products = basketItems.value
        if let index = products.firstIndex(where: {$0.id == product.id}) {
            let indexData = products[index]
            if indexData.numberOfAvailableProducts > indexData.numberOfChosenProducts.asInt() {
                products[index].numberOfChosenProducts += product.numberOfChosenProducts
            }
        } else {
            products.append(product)
        }
        basketItems.accept(products)
    }
    
    private func removeFromArray(product: BasketProductsModel) {
        var products = basketItems.value
        guard let index = products.firstIndex(where: {$0.id == product.id}) else { return }
        let indexData = products[index]
        if indexData.numberOfChosenProducts > 0 {
            products[index].numberOfChosenProducts -= product.numberOfChosenProducts
        } else if indexData.numberOfChosenProducts == 0 {
            products.remove(at: index)
        }
        basketItems.accept(products)
        removeProductIfNeeded()
    }
    
    private func removeProductIfNeeded() {
        var products = basketItems.value
        products.forEach { product in
            if product.numberOfChosenProducts == 0 {
                guard let index = products.firstIndex(where: {$0.id == product.id}) else { return }
                products.remove(at: index)
                basketItems.accept(products)
                print("WRC removeProductIfNeeded at index: \(index)")
            }
        }
    }
    
    
}
