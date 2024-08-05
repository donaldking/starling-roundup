import Foundation

public struct Transaction: Codable {
    public var id: String?
    public var categoryId: String?
    public var amount: Amount?
    public var sourceAmount: SourceAmount?
    public var direction: String?
    public var updatedAt: String?
    public var transactionTime: String?
    public var settlementTime: String?
    public var source: String?
    public var status: String?
    public var transactingApplicationUserUid: String?
    public var counterPartyType: String?
    public var counterPartyUid: String?
    public var counterPartyName: String?
    public var country: String?
    public var spendingCategory: String?
    public var hasAttachment: Bool
    public var hasReceipt: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id = "feedItemUid"
        case categoryId = "categoryUid"
        case amount
        case sourceAmount
        case direction
        case updatedAt
        case transactionTime
        case settlementTime
        case source
        case status
        case transactingApplicationUserUid
        case counterPartyType
        case counterPartyUid
        case counterPartyName
        case country
        case spendingCategory
        case hasAttachment
        case hasReceipt
    }
    
    public init(id: String? = nil, categoryId: String? = nil, amount: Amount? = nil, sourceAmount: SourceAmount? = nil, direction: String? = nil, updatedAt: String? = nil, transactionTime: String? = nil, settlementTime: String? = nil, source: String? = nil, status: String? = nil, transactingApplicationUserUid: String? = nil, counterPartyType: String? = nil, counterPartyUid: String? = nil, counterPartyName: String? = nil, country: String? = nil, spendingCategory: String? = nil, hasAttachment: Bool, hasReceipt: Bool) 
    {
        self.id = id
        self.categoryId = categoryId
        self.amount = amount
        self.sourceAmount = sourceAmount
        self.direction = direction
        self.updatedAt = updatedAt
        self.transactionTime = transactionTime
        self.settlementTime = settlementTime
        self.source = source
        self.status = status
        self.transactingApplicationUserUid = transactingApplicationUserUid
        self.counterPartyType = counterPartyType
        self.counterPartyUid = counterPartyUid
        self.counterPartyName = counterPartyName
        self.country = country
        self.spendingCategory = spendingCategory
        self.hasAttachment = hasAttachment
        self.hasReceipt = hasReceipt
    }
}

public extension Transaction {
    func roundUpAmountInMinorUnits() -> Int {
        guard self.spendingCategory == "PAYMENTS" else { return 0 }
        if let minorUnitsAmount = amount?.minorUnits {
            let decimalPart = round((modf((Double(minorUnitsAmount) / 100)).1) * 100)
            return 100 - Int(decimalPart)
        }
        return 0
    }
}
