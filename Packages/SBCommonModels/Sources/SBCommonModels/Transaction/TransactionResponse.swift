import Foundation

public struct TransactionResponse: Codable {
    public var transactionItems: [Transaction] = []
    
    private enum CodingKeys: String, CodingKey {
        case transactionItems = "feedItems"
    }
}
