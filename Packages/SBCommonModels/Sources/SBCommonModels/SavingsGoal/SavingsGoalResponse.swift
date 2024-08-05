public struct SavingsGoalResponse: Codable {
    public var savingsGoalList: [SavingsGoal] = []
    
    public init(savingsGoalList: [SavingsGoal]) {
        self.savingsGoalList = savingsGoalList
    }
}
