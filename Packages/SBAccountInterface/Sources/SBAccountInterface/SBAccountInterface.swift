import UIKit

import SBWebClientInterface

public protocol SBAccountInterface {
    func makeSBAccountsModule(navigationController: UINavigationController?, webClient: SBWebClientInterface) -> UIViewController
}
