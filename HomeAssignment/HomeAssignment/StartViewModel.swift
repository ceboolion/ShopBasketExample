import Foundation
import RxSwift
import RxCocoa

final class StartViewModel: BasketManager {
    
    //MARK: - PUBLIC PROPERTIES
    let productsData: BehaviorRelay<[ProductModel]> = BehaviorRelay(value: [])
    
    //MARK: - PRIVATE PROPERTIES
    private var networkingService: NetworkingService?
    
    // MARK: INIT
    override init() {
        super.init()
        productsData.accept(getProducts())
    }
    
    //MARK: - PRIVATE METHODS
    private func getProducts() -> [ProductModel] {
        var data: [ProductModel] = []
        for product in ProductType.allCases {
            switch product {
            case .milk:
                data.append(ProductModel(product: .milk, productPrice: 1.30, itemsAvailable: 20, unitOfMeasure: .bottle))
            case .egg:
                data.append(ProductModel(product: .egg, productPrice: 2.10, itemsAvailable: 10, unitOfMeasure: .dozen))
            case .banana:
                data.append(ProductModel(product: .banana, productPrice: 0.73, itemsAvailable: 5, unitOfMeasure: .kg))
            case .potato:
                data.append(ProductModel(product: .potato, productPrice: 0.95, itemsAvailable: 8, unitOfMeasure: .bag))
            case .none:
                break
            }
        }
        return data
    }
    
}
