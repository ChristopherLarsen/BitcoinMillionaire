//
//  AddBitcoinPresenter.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation
import UIKit

protocol AddBitcoinPresenterProtocol {
    func addBitcoin(amount: Float) -> Result<Bool, Error>
    func showErrorMessage(_ error: Error, on viewController: UIViewController, animated : Bool)
    func dismiss(_ viewController: AddBitcoinViewController, animated: Bool)
}

class AddBitcoinPresenter : AddBitcoinPresenterProtocol {
    
    var interactor : AddBitcoinInteractorProtocol
    var router : AddBitcoinRouterProtocol
    
    init(interactor : AddBitcoinInteractorProtocol = AddBitcoinInteractor(), router : AddBitcoinRouterProtocol = AddBitcoinRouter()) {
        self.interactor = interactor
        self.router = router
    }
    
    func addBitcoin(amount: Float) -> Result<Bool, Error> {
        return interactor.addBitcoin(amount:amount)
    }
    
    func dismiss(_ viewController: AddBitcoinViewController, animated : Bool) {
        router.dismiss(viewController: viewController, animated: animated)
    }
    
    /// Display error alert message  in the view controller
    /// - Parameters:
    ///   - error: Error containing message to be displayed
    ///   - on: View Controller to display the view controller
    func showErrorMessage(_ error: Error, on viewController: UIViewController, animated : Bool) {
        let message = error.localizedDescription
        //create alert message
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        viewController.present(alert, animated: animated) {
            print("completed")
        }
    }
    
    
}
