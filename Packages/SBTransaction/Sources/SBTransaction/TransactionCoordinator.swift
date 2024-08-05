import Foundation
import UIKit

import SBWebClientInterface
import SBFoundation

protocol TransactionCoordinatorProtocol {
    init(navigationController: UINavigationController?,
         webClient: any SBWebClientInterface,
         accountId: String,
         categoryId: String,
         timeAgo: SBTimeAgo)
    func makeViewController() -> UIViewController
}

public final class TransactionCoordinator: TransactionCoordinatorProtocol {
    private weak var navigationController: UINavigationController?
    private var webClient: any SBWebClientInterface
    private var accountId: String
    private var categoryId: String
    private var timeAgo: SBTimeAgo
    
    init(navigationController: UINavigationController? = nil,
         webClient: any SBWebClientInterface,
         accountId: String,
         categoryId: String,
         timeAgo: SBTimeAgo)
    {
        self.navigationController = navigationController
        self.webClient = webClient
        self.accountId = accountId
        self.categoryId = categoryId
        self.timeAgo = timeAgo
    }
    
    func makeViewController() -> UIViewController {
        let viewModel = TransactionsListViewModel(coordinator: self,
                                                  webClient: self.webClient,
                                                  accountId: self.accountId,
                                                  categoryId: self.categoryId,
                                                  timeAgo: self.timeAgo)
        return TransactionViewController(viewModel: viewModel)
    }
}
