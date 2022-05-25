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
        guard let rootNavigationController = UINavigationController.rootNavigationController else {
            print("Error - Invalid Application Architecture, no root UINavigationController.")
            return
        }
        let addBitcoinViewController = AddBitcoinViewController()
        rootNavigationController.pushViewController(addBitcoinViewController, animated: true)
    }
    
    func openSellBitcoinView() {
        guard let rootNavigationController = UINavigationController.rootNavigationController else {
            print("Error - Invalid Application Architecture, no root UINavigationController.")
            return
        }
        let removeBitcoinViewController = RemoveBitcoinViewController()
        rootNavigationController.pushViewController(removeBitcoinViewController, animated: true)
    }
    
    func openMillionaireView() {
        guard let rootNavigationController = UINavigationController.rootNavigationController else {
            print("Error - Invalid Application Architecture, no root UINavigationController.")
            return
        }
        let millionaireViewController = MillionaireViewController()
        rootNavigationController.pushViewController(millionaireViewController, animated: true)
    }
    
}
