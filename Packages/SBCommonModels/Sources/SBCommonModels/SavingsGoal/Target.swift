public struct Target: Codable {
    public var currency: String?
    public var minorUnits: Int
    
    public init(currency: String? = nil, minorUnits: Int) {
        self.currency = currency
        self.minorUnits = minorUnits
    }
}
