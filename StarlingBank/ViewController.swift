//
//  ViewController.swift
//  StarlingBank
//
//  Created by Mac User on 27/07/2024.
//

import UIKit
import SBDependencyContainer
import SBNetworkInterface

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let network = DC.shared.resolve(dependency: .singleInstance, for: SBNetworkInterface.self)
        print("Network component found: \(network)")
        
    }
}

