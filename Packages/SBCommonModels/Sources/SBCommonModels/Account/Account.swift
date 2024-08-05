public struct Account: Codable {
    public var id: String?
    public var type: String?
    public var name: String?
    public var defaultCategoryId: String?
    public var currency: String?
    public var createdAt: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "accountUid"
        case type = "accountType"
        case name = "name"
        case defaultCategoryId = "defaultCategory"
        case currency
        case createdAt
    }
    
    public init(id: String? = nil, 
                type: String? = nil,
                name: String? = nil,
                defaultCategoryId: String? = nil,
                currency: String? = nil,
                createdAt: String? = nil)
    {
        self.id = id
        self.type = type
        self.name = name
        self.defaultCategoryId = defaultCategoryId
        self.currency = currency
        self.createdAt = createdAt
    }
}
