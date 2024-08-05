public struct AddMoneyResponse: Codable {
    public var transferId: String?
    public var success: Bool
    
    private enum CodingKeys: String, CodingKey {
        case transferId = "transferUid"
        case success
    }
    
    public init(transferId: String? = nil, success: Bool) {
        self.transferId = transferId
        self.success = success
    }
}
