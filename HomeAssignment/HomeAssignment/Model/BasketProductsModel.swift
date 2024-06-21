import Foundation

struct BasketProductsModel: ProductModelProtocol {
    var id: UUID
    var product: ProductType
    var productPrice: Double
    var unitOfMeasure: UnitsOfMeasure
    var numberOfChosenProducts: Double
    var numberOfAvailableProducts: Int
    
    func getProductModel() -> ProductModel {
        ProductModel(id: id, 
                     product: product,
                     productPrice: productPrice,
                     itemsAvailable: numberOfAvailableProducts,
                     unitOfMeasure: unitOfMeasure)
    }
}
