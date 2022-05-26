//
//  RemoveBitcoinPresenter.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation
import UIKit

protocol RemoveBitcoinPresenterProtocol {
    
    func removeBitcoin(amount: Double) -> Result<Bool, Error>
    func showErrorMessage(_ error: Error, on viewController: UIViewController, animated : Bool)
    func dismiss(_ viewController: RemoveBitcoinViewController, animated: Bool)
}

class RemoveBitcoinPresenter : RemoveBitcoinPresenterProtocol {
    
    var interactor : RemoveBitcoinInteractorProtocol
    var router : RemoveBitcoinRouterProtocol = RemoveBitcoinRouter()
    
    init(interactor : RemoveBitcoinInteractorProtocol = RemoveBitcoinInteractor()) {
        self.interactor = interactor
    }
    
    func removeBitcoin(amount: Double) -> Result<Bool, Error> {
        return interactor.removeBitcoin(amount:amount)
    }
    
    func showErrorMessage(_ error: Error, on viewController: UIViewController, animated: Bool) {
        let message = error.localizedDescription
        //create alert message
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        
        viewController.present(alert, animated: true)
    }
    
    func dismiss(_ viewController: RemoveBitcoinViewController, animated: Bool) {
        router.dismiss(viewController: viewController)
    }
}
