final class MockSavingsGoalCreationViewModelDelegate: SavingsGoalCreationViewModelDelegate {
    var didCreateSavingsGoalIsCalled = false
    var savingsGoalId = ""
    
    func didCreateSavingsGoal(savingsGoalId: String) {
        self.didCreateSavingsGoalIsCalled = true
        self.savingsGoalId = savingsGoalId
    }
}
