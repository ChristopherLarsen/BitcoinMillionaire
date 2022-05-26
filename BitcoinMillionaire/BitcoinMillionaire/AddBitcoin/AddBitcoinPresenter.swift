//
//  AddBitcoinPresenter.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation
import UIKit

protocol AddBitcoinPresenterProtocol {
    func addBitcoin(amount: Float) throws
    func showErrorMessage(_ error: Error, on viewController: AddBitcoinViewController)
    func dismiss(_ viewController: AddBitcoinViewController)
}

class AddBitcoinPresenter : AddBitcoinPresenterProtocol {
    
    var interactor : AddBitcoinInteractorProtocol
    var router : AddBitcoinRouterProtocol = AddBitcoinRouter()
    
    init(interactor : AddBitcoinInteractorProtocol = AddBitcoinInteractor()) {
        self.interactor = interactor
    }
    
    func addBitcoin(amount: Float) throws {
        try interactor.addBitcoin(amount:amount)
    }
    
    func dismiss(_ viewController: AddBitcoinViewController) {
        router.dismiss(viewController: viewController)
    }
    
    /// Display error alert message  in the view controller
    /// - Parameters:
    ///   - error: Error containing message to be displayed
    ///   - on: View Controller to display the view controller
    func showErrorMessage(_ error: Error, on viewController: AddBitcoinViewController) {
        let message = error.localizedDescription
        //create alert message
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        
        viewController.present(alert, animated: true)
    }
    
    
}
