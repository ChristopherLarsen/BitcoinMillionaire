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
}

// MARK: - MillionairePresenter

class MillionairePresenter : MillionairePresenterProtocol {
        
    let millionaireInteractor: MillionaireInteractorProtocol
    let millionaireRouter: MillionaireRouterProtocol
    
    var millionaireViewController: MillionaireViewControllerProtocol?

    required init(interactor: MillionaireInteractorProtocol, router: MillionaireRouterProtocol) {
        self.millionaireInteractor = interactor
        self.millionaireRouter = router
    }
    
}
