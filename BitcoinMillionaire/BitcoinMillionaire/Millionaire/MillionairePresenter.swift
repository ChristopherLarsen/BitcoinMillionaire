//
//  MillionairePresenter.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-24.
//

import Foundation


// MARK: - MillionairePresenterProtocol

protocol MillionairePresenterProtocol {
    var millionaireViewController: MillionaireViewControllerProtocol? { get set }
    func checkIfUserIsBitcoinMillionaire()
    func calculatedUser(isMillionaire: Bool)
}

// MARK: - MillionairePresenter

class MillionairePresenter : MillionairePresenterProtocol {
        
    var millionaireInteractor: MillionaireInteractorProtocol
    var millionaireRouter: MillionaireRouterProtocol
            
    var millionaireViewController: MillionaireViewControllerProtocol?

    required init(interactor: MillionaireInteractorProtocol = MillionaireInteractor(),
                  router: MillionaireRouterProtocol = MillionaireRouter() ) {
        self.millionaireInteractor = interactor
        self.millionaireRouter = router
    }

    func checkIfUserIsBitcoinMillionaire() {
        millionaireInteractor.calculateUserBitcoinMillionaireStatus()
    }
    
    func calculatedUser(isMillionaire: Bool) {
        
        guard let millionaireViewController = millionaireViewController else {
            print("Error - We lost the millionaireViewController.")
            return
        }
        
        millionaireViewController.isBitcoinMillionaire.send(isMillionaire)
    }
    
}

