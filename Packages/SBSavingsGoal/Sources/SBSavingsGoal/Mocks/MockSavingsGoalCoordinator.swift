import UIKit

import SBWebClientInterface

final class MockSavingsGoalCoordinator: SavingsGoalCoordinatorProtocol {
    var goToSavingsGoalDetailsCalled = false
    var goToCreateSavingGoalsScreeenCalled = false
    
    init(navigationController: UINavigationController?, 
         webClient: any SBWebClientInterface,
         accountId: String,
         categoryId: String) 
    {
        
    }
    
    init() {}
    
    func makeViewController() -> UIViewController {
        return UIViewController()
    }
    
    func goToSavingsGoalDetails(savingsGoalId: String, delegate: any SavingsGoalDetailsViewModelDelegate) {
        self.goToSavingsGoalDetailsCalled = true
    }
    
    func goToCreateSavingGoalsScreeen(delegate: any SavingsGoalCreationViewModelDelegate) {
        self.goToCreateSavingGoalsScreeenCalled = true
    }
}
