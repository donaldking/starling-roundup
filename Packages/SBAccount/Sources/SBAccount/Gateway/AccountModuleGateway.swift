import UIKit

import SBAccountInterface
import SBWebClientInterface

public struct AccountModuleGateway: SBAccountInterface {
    public init() {}
    
    public func makeSBAccountsModule(navigationController: UINavigationController?, 
                                     webClient: any SBWebClientInterface) -> UIViewController
    {
        return AccountCoordinator(navigationController: navigationController,
                                  webClient: webClient).makeViewController()
    }
}
