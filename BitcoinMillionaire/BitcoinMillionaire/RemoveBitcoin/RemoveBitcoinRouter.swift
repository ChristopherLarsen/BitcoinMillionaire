//
//  RemoveBitcoinRouter.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation

protocol RemoveBitcoinRouterProtocol {
    func dismiss(viewController : RemoveBitcoinViewController)
}

class RemoveBitcoinRouter : RemoveBitcoinRouterProtocol {
    func dismiss(viewController : RemoveBitcoinViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
}
