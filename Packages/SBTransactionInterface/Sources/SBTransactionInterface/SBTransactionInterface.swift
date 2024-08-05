import UIKit

import SBWebClientInterface
import SBFoundation

public protocol SBTransactionInterface {
    func makeSBTransactionModule(navigationController: UINavigationController?,
                                 webClient: SBWebClientInterface,
                                 accountId: String,
                                 categoryId: String,
                                 timeAgo: SBTimeAgo) -> UIViewController
}
