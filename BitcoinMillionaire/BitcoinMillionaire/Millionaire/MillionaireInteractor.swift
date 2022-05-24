//
//  MillionaireInteractor.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-24.
//

import Foundation

// MARK: - MillionaireInteractorProtocol

protocol MillionaireInteractorProtocol {
    var millionairePresenter: MillionairePresenterProtocol? { get set }
    func checkIfUserIsBitcoinMillionaire()
}

// MARK: - MillionaireInteractor

class MillionaireInteractor : MillionaireInteractorProtocol {
    
    var millionairePresenter: MillionairePresenterProtocol?
    
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
            
            guard let millionairePresenter = self.millionairePresenter else {
                return
            }

            // TODO: Handle failure to fetch price better
            
            millionairePresenter.calculatedUser(isMillionaire: false)
            
        } receiveValue: { [weak self] bitcoinPrice in
            
            guard let self = self else {
                return
            }
            
            guard let millionairePresenter = self.millionairePresenter else {
                return
            }
            
            let isMillionaire = bitcoins * Float(bitcoinPrice) > Constants.oneMillionDollars
            millionairePresenter.calculatedUser(isMillionaire: isMillionaire)
            
        }
        
    }
    
}
