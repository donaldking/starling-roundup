import UIKit

import SBWebClientInterface

public protocol SBSavingsGoalInterface {
    func makeSBSavingsGoalModule(navigationController: UINavigationController?,
                                 webClient: SBWebClientInterface,
                                 accountId: String,
                                 categoryId: String) -> UIViewController
}
