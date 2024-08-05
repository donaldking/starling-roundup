import UIKit

import SBFoundation
import SBWebClientInterface

final class MockAccountCoordinator: AccountCoordinatorProtocol {
    var goToTransactionsCalled = false
    var goToSavingsGoalsCalled = false
    
    init(navigationController: UINavigationController?, webClient: any SBWebClientInterface) {
        
    }
    
    init() {}
    
    func makeViewController() -> UIViewController {
        return UIViewController()
    }
    
    func goToTransactions(accountId: String, categoryId: String, timeAgo: SBTimeAgo) {
        goToTransactionsCalled = true
    }
    
    func goToSavingsGoals(accountId: String, categoryId: String) {
        goToSavingsGoalsCalled = true
    }
}
