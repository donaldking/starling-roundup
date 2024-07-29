//
//  ViewController.swift
//  StarlingBank
//
//  Created by Mac User on 27/07/2024.
//

import UIKit
import SBDependencyContainer
import SBAccounts
import SBAccountsInterface
import SBTransactions
import SBTransactionsInterface
import SBSavingsGoals
import SBSavingsGoalsInterface

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let accountsGateway = DC.shared.resolve(dependency: .closure, for: SBAccountsInterface.self)
        print("Resolved accounts gateway: \(accountsGateway)")
        
        let transactionsGateway = DC.shared.resolve(dependency: .closure, for: SBTransactionsInterface.self)
        print("Resolved transactions gateway: \(transactionsGateway)")
        
        let savingGoalsGateway = DC.shared.resolve(dependency: .closure, for: SBSavingsGoalsInterface.self)
        print("Resolved savings goals gateway: \(savingGoalsGateway)")
    }
}
