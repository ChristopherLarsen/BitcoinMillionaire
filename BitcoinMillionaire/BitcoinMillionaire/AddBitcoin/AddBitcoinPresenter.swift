//
//  AddBitcoinPresenter.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation

protocol AddBitcoinPresenterProtocol { }

class AddBitcoinPresenter : AddBitcoinPresenterProtocol {
    
    var interactor : AddBitcoinInteractorProtocol
    
    init(interactor : AddBitcoinInteractorProtocol = AddBitcoinInteractor()) {
        self.interactor = interactor
    }
    
    
}
