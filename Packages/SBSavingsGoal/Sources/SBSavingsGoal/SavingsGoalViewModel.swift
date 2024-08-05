import SBCommonModels

protocol SavingsGoalViewModelProtocol {
    init(savingsGoal: SavingsGoal)
    var id: String { get }
    var name: String { get }
    var currency: String { get }
    var targetAmountMinorUnits: Int { get }
    var totalSavedMinorUnits: Int { get }
    var savedPercentage: Int { get }
    var targetAmountDisplay: String { get }
    var totalSavedDisplay: String { get }
    var savedPercentageDisplay: String { get }
}

final class SavingsGoalViewModel: SavingsGoalViewModelProtocol {
    private var savingsGoal: SavingsGoal
    var id: String {
        return savingsGoal.id ?? ""
    }
    var name: String {
        return savingsGoal.name ?? ""
    }
    var currency: String {
        return savingsGoal.target?.currency ?? ""
    }
    var targetAmountMinorUnits: Int {
        return savingsGoal.target?.minorUnits ?? 0
    }
    var totalSavedMinorUnits: Int {
        return savingsGoal.totalSaved?.minorUnits ?? 0
    }
    var savedPercentage: Int {
        return savingsGoal.savedPercentage
    }
    var targetAmountDisplay: String {
        return savingsGoal.target?.minorUnits.floatValue.moneyFormat(currency) ?? "\(currency) 0"
    }
    var totalSavedDisplay: String {
        return savingsGoal.totalSaved?.minorUnits.floatValue.moneyFormat(currency) ?? "\(currency) 0"
    }
    var savedPercentageDisplay: String {
        return "\(savingsGoal.savedPercentage)%"
    }
    
    init(savingsGoal: SavingsGoal) {
        self.savingsGoal = savingsGoal
    }
}
