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
    func actionDone()
}

// MARK: - MillionairePresenter

class MillionairePresenter : MillionairePresenterProtocol {
        
    var millionaireInteractor: MillionaireInteractorProtocol
    var millionaireRouter: MillionaireRouterProtocol
            
    var millionaireViewController: MillionaireViewControllerProtocol?

    // Mark: init
    
    required init(interactor: MillionaireInteractorProtocol = MillionaireInteractor(), router: MillionaireRouterProtocol = MillionaireRouter() ) {
        self.millionaireInteractor = interactor
        self.millionaireRouter = router
        self.millionaireInteractor.millionairePresenter = self
        self.millionaireRouter.millionairePresenter = self
    }

    // MARK: MillionairePresenterProtocol
    
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

// MARK: - Received Actions

extension MillionairePresenter {
    
    func actionDone() {
        millionaireRouter.navigateBack()
    }
    
}
