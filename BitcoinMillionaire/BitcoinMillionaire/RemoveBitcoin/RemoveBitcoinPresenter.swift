//
//  RemoveBitcoinPresenter.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation
import UIKit

protocol RemoveBitcoinPresenterProtocol {
    func removeBitcoin(amount: Float) throws
    func showErrorMessage(_ error: Error, on viewController: RemoveBitcoinViewController)
    func dismiss(_ viewController: RemoveBitcoinViewController)
}

class RemoveBitcoinPresenter : RemoveBitcoinPresenterProtocol {
    
    var interactor : RemoveBitcoinInteractorProtocol
    var router : RemoveBitcoinRouterProtocol = RemoveBitcoinRouter()
    
    init(interactor : RemoveBitcoinInteractorProtocol = RemoveBitcoinInteractor()) {
        self.interactor = interactor
    }
    
    func showErrorMessage(_ error: Error, on viewController: RemoveBitcoinViewController) {
        let message = error.localizedDescription
        //create alert message
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        
        viewController.present(alert, animated: true)
    }
    
    func removeBitcoin(amount: Float) throws {
        try interactor.removeBitcoin(amount:amount)
    }
    
    func dismiss(_ viewController: RemoveBitcoinViewController) {
        router.dismiss(viewController: viewController)
    }
}
