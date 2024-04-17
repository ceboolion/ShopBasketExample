import Foundation

protocol ProductModelProtocol {
    var id: UUID { get set }
    var product: ProductType { get set }
    var productPrice: Double { get set }
    var unitOfMeasure: UnitsOfMeasure { get set }
}

struct ProductModel: ProductModelProtocol {
    var id = UUID()
    var product: ProductType
    var productPrice: Double
    var itemsAvailable: Int
    var unitOfMeasure: UnitsOfMeasure
    
    func getItemsQuantity() -> String {
        switch unitOfMeasure {
        case .bag:
            itemsAvailable > 1 ? "Torby" : "Torba"
        case .dozen:
            getDozensText()
        case .bottle:
            itemsAvailable > 1 ? "Butelki" : "Butelka"
        case .kg:
            itemsAvailable > 1 ? "Kilogramy" : "Kilogram"
        case .none:
            ""
        }
    }
    
    private func getDozensText() -> String {
        if unitOfMeasure == .dozen {
            switch itemsAvailable {
            case 0...1:
                return "Tuzin"
            case 2...4:
                return "Tuziny"
            default:
                return "Tuzinów"
            }
        }
        return ""
    }
    
    func mapProductModel(numberOfChosenProducts: Double) -> BasketProductsModel {
        BasketProductsModel(id: id,
                            product: product,
                            productPrice: productPrice,
                            unitOfMeasure: unitOfMeasure,
                            numberOfChosenProducts: numberOfChosenProducts,
                            numberOfAvailableProducts: itemsAvailable)
    }
}
