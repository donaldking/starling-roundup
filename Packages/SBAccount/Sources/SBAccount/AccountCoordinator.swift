import UIKit

import SBCommonModels
import SBWebClientInterface
import SBDependencyContainer
import SBTransactionInterface
import SBSavingsGoalInterface
import SBFoundation

protocol AccountCoordinatorProtocol {
    init(navigationController: UINavigationController?, webClient: any SBWebClientInterface)
    func makeViewController() -> UIViewController
    func goToTransactions(accountId: String, categoryId: String, timeAgo: SBTimeAgo)
    func goToSavingsGoals(accountId: String, categoryId: String)
}

final class AccountCoordinator: AccountCoordinatorProtocol {
    private weak var navigationController: UINavigationController?
    private var webClient: any SBWebClientInterface
    
    init(navigationController: UINavigationController? = nil, webClient: any SBWebClientInterface) {
        self.navigationController = navigationController
        self.webClient = webClient
    }
    
    func makeViewController() -> UIViewController {
        let viewModel = AccountListViewModel(coordinator: self, webClient: self.webClient, accountViewModels: [])
        return AccountListViewController(viewModel: viewModel)
    }
    
    // Navigate to Transactions module / package using dependency container
    func goToTransactions(accountId: String, categoryId: String, timeAgo: SBTimeAgo) {
        let gateway = DC.shared.resolve(dependency: .closure, for: SBTransactionInterface.self)
        let viewController = gateway.makeSBTransactionModule(navigationController: self.navigationController,
                                                             webClient: self.webClient,
                                                             accountId: accountId,
                                                             categoryId: categoryId,
                                                             timeAgo: timeAgo)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // Navigate to Savigs Goals module / package using dependency container
    func goToSavingsGoals(accountId: String, categoryId: String) {
        let gateway = DC.shared.resolve(dependency: .closure, for: SBSavingsGoalInterface.self)
        let viewController = gateway.makeSBSavingsGoalModule(navigationController: self.navigationController,
                                                             webClient: self.webClient,
                                                             accountId: accountId,
                                                             categoryId: categoryId)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
