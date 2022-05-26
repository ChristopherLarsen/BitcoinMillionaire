//
//  AddBitcoinRouter.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation

protocol AddBitcoinRouterProtocol {
    func dismiss(viewController : AddBitcoinViewController)
}

class AddBitcoinRouter : AddBitcoinRouterProtocol {
    
    func dismiss(viewController : AddBitcoinViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
    
}




