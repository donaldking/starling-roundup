public struct CreateSavingsGoalResponse: Codable {
    public var savingsGoalId: String?
    public var success: Bool
    
    private enum CodingKeys: String, CodingKey {
        case savingsGoalId = "savingsGoalUid"
        case success
    }
    
    public init(savingsGoalId: String? = nil, success: Bool) {
        self.savingsGoalId = savingsGoalId
        self.success = success
    }
}
