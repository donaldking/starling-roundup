final class MockSavingsGoalDetailsViewModelDelegate: SavingsGoalDetailsViewModelDelegate {
    var didAddIsCalled = false
    var minorUnits = 0
    var savingsGoalId = ""
    
    func didAdd(roundUp minorUnits: Int, savingsGoalId: String) {
        self.didAddIsCalled = true
        self.minorUnits = minorUnits
        self.savingsGoalId = savingsGoalId
    }
}
