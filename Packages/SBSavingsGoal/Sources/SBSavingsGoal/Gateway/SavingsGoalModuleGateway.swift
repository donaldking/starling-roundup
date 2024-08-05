import UIKit

import SBSavingsGoalInterface
import SBWebClientInterface

public struct SavingsGoalModuleGateway: SBSavingsGoalInterface {
    public init() {}
    
    public func makeSBSavingsGoalModule(navigationController: UINavigationController?, 
                                        webClient: any SBWebClientInterface,
                                        accountId: String,
                                        categoryId: String) -> UIViewController
    {
        return SavingsGoalCoordinator(navigationController: navigationController,
                                      webClient: webClient,
                                      accountId: accountId,
                                      categoryId: categoryId).makeViewController()
    }
}
