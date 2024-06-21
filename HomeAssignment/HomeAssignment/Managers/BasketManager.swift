import Foundation
import RxSwift

class BasketManager {
    
    //MARK: - PUBLIC PROPERTIES
    let disposeBag = DisposeBag()
    
    //MARK: - PUBLIC METHODS
    func updateShoppingData(updateType: BasketUpdateType, data: ProductModel) {
        updateType == .add ? addProduct(for: data) : removeProduct(for: data)
    }
    
    func removeItem(for index: Int) {
        var products = ShoppingBasket.shared.basketItems.value
        products.remove(at: index)
        ShoppingBasket.shared.deleteBasketProduct(products: products)
    }
    
    //MARK: - PRIVATE METHODS
    private func addProduct(for data: ProductModel) {
        var products = ShoppingBasket.shared.basketItems.value
        if let index = products.firstIndex(where: {$0.id == data.id}) {
            let indexData = products[index]
            if indexData.numberOfAvailableProducts > indexData.numberOfChosenProducts.asInt() {
                products[index].numberOfChosenProducts += 1
                ShoppingBasket.shared.addProduct(products: products)
            }
        } else {
            products.append(data.mapProductModel(numberOfChosenProducts: 1))
            ShoppingBasket.shared.addProduct(products: products)
        }
    }
    
    private func removeProduct(for data: ProductModel) {
        var products = ShoppingBasket.shared.basketItems.value
        guard let index = products.firstIndex(where: {$0.id == data.id}) else { return }
        let indexData = products[index]
        if indexData.numberOfChosenProducts > 0 {
            products[index].numberOfChosenProducts -= 1
            ShoppingBasket.shared.removeProduct(products: products)
        } else if indexData.numberOfChosenProducts == 0 {
            products.remove(at: index)
            ShoppingBasket.shared.removeProduct(products: products)
        }
    }
    
}
