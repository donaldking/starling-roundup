public struct SavingsGoal: Codable {
    public var id: String?
    public var name: String?
    public var target: Target?
    public var totalSaved: TotalSaved?
    public var savedPercentage: Int
    public var state: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "savingsGoalUid"
        case name
        case target
        case totalSaved
        case savedPercentage
        case state
    }
    
    public init(id: String? = nil,
         name: String? = nil,
         target: Target? = nil,
         totalSaved: TotalSaved? = nil,
         savedPercentage: Int = 0,
         state: String? = nil)
    {
        self.id = id
        self.name = name
        self.target = target
        self.totalSaved = totalSaved
        self.savedPercentage = savedPercentage
        self.state = state
    }
}
