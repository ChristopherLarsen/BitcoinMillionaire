//
//  RemoveBitcoinPresenter.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation

protocol RemoveBitcoinPresenterProtocol { }

class RemoveBitcoinPresenter : RemoveBitcoinPresenterProtocol {
    
    var interactor : RemoveBitcoinInteractorProtocol
    
    init(interactor : RemoveBitcoinInteractorProtocol = RemoveBitcoinInteractor()) {
        self.interactor = interactor
    }
    
    
}
