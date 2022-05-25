//
//  AddBitcoinPresenter.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation

// MARK: - AddBitcoinPresenterProtocol

protocol AddBitcoinPresenterProtocol {
    func finishedAddingBitcoin()
}

// MARK: - AddBitcoinPresenter

class AddBitcoinPresenter : AddBitcoinPresenterProtocol {
    
    var interactor : AddBitcoinInteractorProtocol
    
    init(interactor : AddBitcoinInteractorProtocol = AddBitcoinInteractor()) {
        self.interactor = interactor
    }

    func finishedAddingBitcoin() {
        //TODO: router?.goBack()
    }

}
