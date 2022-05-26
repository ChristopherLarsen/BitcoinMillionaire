//
//  AddBitcoinRouter.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation

protocol AddBitcoinRouterProtocol {
    func dismiss(viewController : AddBitcoinViewController, animated : Bool)
}

class AddBitcoinRouter : AddBitcoinRouterProtocol {
    
    func dismiss(viewController : AddBitcoinViewController, animated : Bool = true) {
        viewController.navigationController?.popViewController(animated: animated)
    }
    
}




