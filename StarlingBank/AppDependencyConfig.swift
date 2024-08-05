import SBDependencyContainer
import SBAccount
import SBAccountInterface
import SBTransaction
import SBTransactionInterface
import SBSavingsGoal
import SBSavingsGoalInterface
import SBWebClient
import SBWebClientInterface

// MARK: - IMPORTANT!! Please change this token to YOUR OWN token. Developer tokens expires after 24hrs. Refresh token was not implemented in this sample app.
private let token = ""

enum AppDependencyConfig {
    static func configure() {
        // Register accounts module gateway
        let accountGatewayClosure: () -> SBAccountInterface = { AccountModuleGateway() }
        DC.shared.register(dependency: .closure(accountGatewayClosure), for: SBAccountInterface.self)
        
        // Register transactions module gateway
        let transactionGatewayClosure: () -> SBTransactionInterface = { TransactionModuleGateway() }
        DC.shared.register(dependency: .closure(transactionGatewayClosure), for: SBTransactionInterface.self)
        
        // Register savings goals module gateway
        let savingsGoalGatewayClosure: () -> SBSavingsGoalInterface = { SavingsGoalModuleGateway() }
        DC.shared.register(dependency: .closure(savingsGoalGatewayClosure), for: SBSavingsGoalInterface.self)
        
        // Register web client
        let webClient = SBWebClient.shared
        webClient.setToken(token: token)
        DC.shared.register(dependency: .singleInstance(webClient), for: SBWebClientInterface.self)
    }
}
