import SBDependencyContainer
import SBAccounts
import SBAccountsInterface
import SBTransactions
import SBTransactionsInterface
import SBSavingsGoals
import SBSavingsGoalsInterface

enum AppDependencyConfig {
    static func configure() {
        // Register accounts module gateway
        let accountsGatewayClosure: () -> SBAccountsInterface = { AccountsModuleGateway() }
        DC.shared.register(dependency: .closure(accountsGatewayClosure), for: SBAccountsInterface.self)
        
        // Register transactions module gateway
        let transactionsGatewayClosure: () -> SBTransactionsInterface = { TransactionsModuleGateway() }
        DC.shared.register(dependency: .closure(transactionsGatewayClosure), for: SBTransactionsInterface.self)
        
        // Register savings goals module gateway
        let savingsGoalsGatewayClosure: () -> SBSavingsGoalsInterface = { SavingsGoalsModuleGateway() }
        DC.shared.register(dependency: .closure(savingsGoalsGatewayClosure), for: SBSavingsGoalsInterface.self)
    }
}
