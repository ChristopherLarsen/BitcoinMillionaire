//
//  MillionaireInteractor.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-24.
//

import Foundation
import Combine

// MARK: - MillionaireInteractorProtocol

protocol MillionaireInteractorProtocol : AnyObject {
    var millionairePresenter: MillionairePresenterProtocol? { get set }
    func calculateUserBitcoinMillionaireStatus()
}

// MARK: - MillionaireInteractor

class MillionaireInteractor : MillionaireInteractorProtocol {
    
    weak var millionairePresenter: MillionairePresenterProtocol?
    
    private var cancellables: Set<AnyCancellable> = []
    
    func calculateUserBitcoinMillionaireStatus() {
        
        let bitcoins = mainStore.state.bitcoinState.bitcoin

        let webservice = WebService()
        let bitcoinPriceService = BitcoinPriceService(webService: webservice)
        let bitcoinPrice = bitcoinPriceService.currentBitcoinPrice.value

        let calculatedValueOfUserBitcoing = calculateCurrentBitcoinValue(forUserBitcoins: bitcoins, bitcoinPrice: bitcoinPrice)
        
        let isMillionaire = calculatedValueOfUserBitcoing > Constants.oneMillionDollars
        
        millionairePresenter?.calculatedUser(isMillionaire: isMillionaire)
        
    }
    
    func calculateCurrentBitcoinValue(forUserBitcoins bitcoins: Double, bitcoinPrice: Float) -> Double {
        let valueOfUserBitcoin = bitcoins * Double(bitcoinPrice)
        return valueOfUserBitcoin
    }
    
}
