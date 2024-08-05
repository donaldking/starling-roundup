import Foundation
import UIKit

import SBCommonModels
import SBWebClientInterface

protocol SavingsGoalCoordinatorProtocol {
    init(navigationController: UINavigationController?,
         webClient: any SBWebClientInterface,
         accountId: String,
         categoryId: String)
    func makeViewController() -> UIViewController
    func goToSavingsGoalDetails(savingsGoalId: String, delegate: any SavingsGoalDetailsViewModelDelegate)
    func goToCreateSavingGoalsScreeen(delegate: any SavingsGoalCreationViewModelDelegate)
}

final class SavingsGoalCoordinator: SavingsGoalCoordinatorProtocol {
    private weak var navigationController: UINavigationController?
    private var webClient: any SBWebClientInterface
    private var accountId: String
    private var categoryId: String
    
    init(navigationController: UINavigationController? = nil,
         webClient: any SBWebClientInterface,
         accountId: String,
         categoryId: String)
    {
        self.navigationController = navigationController
        self.webClient = webClient
        self.accountId = accountId
        self.categoryId = categoryId
    }
    
    func makeViewController() -> UIViewController {
        let viewModel = SavingsGoalListViewModel(coordinator: self,
                                                 accountId: self.accountId,
                                                 webClient: self.webClient,
                                                 savingsGoalsViewModels: [])
        let viewController = SavingsGoalListViewController(accountId: self.accountId,
                                                           viewModel: viewModel)
        return viewController
    }
    
    func goToSavingsGoalDetails(savingsGoalId: String, delegate: any SavingsGoalDetailsViewModelDelegate) {
        let viewModel = SavingsGoalDetailsViewModel(coordinator: self,
                                                    accountId: self.accountId,
                                                    categoryId: self.categoryId,
                                                    savingsGoalId: savingsGoalId,
                                                    delegate: delegate,
                                                    webClient: self.webClient)
        let savingsDetailsViewController = SavingsGoalDetailsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(savingsDetailsViewController, animated: true)
    }
    
    func goToCreateSavingGoalsScreeen(delegate: any SavingsGoalCreationViewModelDelegate) {
        let viewModel = SavingsGoalCreationViewModel(accountId: self.accountId, webClient: self.webClient, delegate: delegate)
        let viewController = SavingsGoalCreationViewController(viewModel: viewModel)
        let tempNavigationController = UINavigationController(rootViewController: viewController)
        self.navigationController?.present(tempNavigationController, animated: true)
    }
    
    deinit {
        print("SavingsGoalCoordinator deinit")
    }
}
