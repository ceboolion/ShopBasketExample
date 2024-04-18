import Foundation

struct CurrencyData: Codable {
    let success: Bool
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
    
    func getCurrencyData() -> [CurrencyModel] {
        var data = [CurrencyModel]()
        quotes.forEach { data.append(CurrencyModel(currency: $0.key.replacingOccurrences(of: "USD", with: ""), 
                                                   currencyData: $0.value)) }
        return data
    }
}

struct CurrencyModel: Codable {
    let currency: String
    let currencyData: Double
}
