//
//  RootCoordinator.swift
//  StarlingBank
//
//  Created by Mac User on 29/07/2024.
//

import UIKit
import SBDependencyContainer
import SBAccountsInterface
import SBNetwork

final class RootCoordinator {
    func makeInitialViewController(navigationController: UINavigationController) {
        let gateway = DC.shared.resolve(dependency: .closure, for: SBAccountsInterface.self)
        let viewController = gateway.makeSBAccountsModule(navigationController: navigationController, networkService: SBNetwork.shared)
        navigationController.viewControllers = [viewController]
    }
}
