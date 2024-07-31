import UIKit

import SBDependencyContainer
import SBAccountsInterface
import SBWebClientInterface

final class RootCoordinator {
    func makeInitialViewController(navigationController: UINavigationController) {
        let gateway = DC.shared.resolve(dependency: .closure, for: SBAccountsInterface.self)
        let webClient = DC.shared.resolve(dependency: .singleInstance, for: SBWebClientInterface.self)
        let viewController = gateway.makeSBAccountsModule(navigationController: navigationController, webClient: webClient)
        navigationController.viewControllers = [viewController]
    }
}
