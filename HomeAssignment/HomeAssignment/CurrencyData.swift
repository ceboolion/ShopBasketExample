import Foundation

struct CurrencyData: Codable {
    let success: Bool
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
    
    func getCurrencyData() -> [CurrencyModel] {
        let usd = "USD"
        var data = [CurrencyModel]()
        quotes.forEach { data.append(CurrencyModel(currency: $0.key.replacingOccurrences(of: usd, with: ""),
                                                   currencyData: $0.value)) }
        data.insert(CurrencyModel(currency: usd, currencyData: 1), at: 0)
        return data
    }
}

struct CurrencyModel: Codable {
    let currency: String
    let currencyData: Double
}
