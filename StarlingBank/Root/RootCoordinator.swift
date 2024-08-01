import UIKit

import SBDependencyContainer
import SBAccountInterface
import SBWebClientInterface

final class RootCoordinator {
    func makeInitialViewController(navigationController: UINavigationController) {
        let gateway = DC.shared.resolve(dependency: .closure, for: SBAccountInterface.self)
        let webClient = DC.shared.resolve(dependency: .singleInstance, for: SBWebClientInterface.self)
        let viewController = gateway.makeSBAccountsModule(navigationController: navigationController, webClient: webClient)
        navigationController.viewControllers = [viewController]
    }
}
