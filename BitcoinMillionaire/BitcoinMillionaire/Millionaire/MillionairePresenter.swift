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
}

// MARK: - MillionairePresenter

class MillionairePresenter : MillionairePresenterProtocol {
        
    let millionaireInteractor: MillionaireInteractorProtocol
    let millionaireRouter: MillionaireRouterProtocol
    
    let oneMillionDollars: Float = 1_000_000
        
    var millionaireViewController: MillionaireViewControllerProtocol?

    required init(interactor: MillionaireInteractorProtocol, router: MillionaireRouterProtocol) {
        self.millionaireInteractor = interactor
        self.millionaireRouter = router
    }

    func checkIfUserIsBitcoinMillionaire() {
        
        let userBitcoinService = UserBitcoinService()
        let bitcoins = userBitcoinService.currentUserBitcoins.value.bitcoins
        checkCurrentBitcoinPrice(forUserBitcoins: bitcoins)
        
    }
        
    func checkCurrentBitcoinPrice(forUserBitcoins bitcoins: Float) {
    
        let webservice = WebService()
        let bitcoinPriceService = BitcoinPriceService(webService: webservice)
        
        let latestBitcoinPricePublisher = bitcoinPriceService.getLatestFromDataBase()
        
        let _ = latestBitcoinPricePublisher.sink { [weak self] error in

            guard let self = self else {
                return
            }

            // TODO: Handle failure to fetch price better
            self.updateUserInterfaceToDisplay(isMillionaire: false)
            
        } receiveValue: { [weak self] bitcoinPrice in
            
            guard let self = self else {
                return
            }
            
            let isMillionaire = bitcoins * Float(bitcoinPrice) > self.oneMillionDollars
            self.updateUserInterfaceToDisplay(isMillionaire: isMillionaire)
            
        }
        
    }
    
    func updateUserInterfaceToDisplay(isMillionaire: Bool) {
        
        guard let millionaireViewController = millionaireViewController else {
            print("Error - We lost the millionaireViewController.")
            return
        }
        
        millionaireViewController.isBitcoinMillionaire.send(isMillionaire)
    }
    
}

