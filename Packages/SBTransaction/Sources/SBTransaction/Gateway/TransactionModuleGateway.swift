import UIKit

import SBTransactionInterface
import SBWebClientInterface
import SBFoundation

public struct TransactionModuleGateway: SBTransactionInterface {
    public init() {}
    
    public func makeSBTransactionModule(navigationController: UINavigationController?,
                                        webClient: any SBWebClientInterface,
                                        accountId: String,
                                        categoryId: String,
                                        timeAgo: SBTimeAgo) -> UIViewController
    {
        return TransactionCoordinator(navigationController: navigationController,
                                      webClient: webClient,
                                      accountId: accountId,
                                      categoryId: categoryId,
                                      timeAgo: timeAgo).makeViewController()
    }
}
