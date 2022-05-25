//
//  HomeRouter.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation
import UIKit

class HomeRouter: HomeRouterProtocol {
    
    func openAddBitcoinView() {
        let rootNavigationController = UINavigationController.rootNavigationController
        let addBitcoinViewController = AddBitcoinViewController()
        rootNavigationController.pushViewController(addBitcoinViewController, animated: true)
    }
    
    func openSellBitcoinView() {
        let rootNavigationController = UINavigationController.rootNavigationController
        let removeBitcoinViewController = RemoveBitcoinViewController()
        rootNavigationController.pushViewController(removeBitcoinViewController, animated: true)
    }
    
    func openMillionaireView() {
        let rootNavigationController = UINavigationController.rootNavigationController
        let millionaireViewController = MillionaireViewController()
        rootNavigationController.pushViewController(millionaireViewController, animated: true)
    }
    
}
