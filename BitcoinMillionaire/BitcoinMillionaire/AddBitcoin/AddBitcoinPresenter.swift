//
//  AddBitcoinPresenter.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation
import UIKit

protocol AddBitcoinPresenterProtocol {
    func addBitcoin(amount: Float)
}

class AddBitcoinPresenter : AddBitcoinPresenterProtocol {
    
    var interactor : AddBitcoinInteractorProtocol
    var router : AddBitcoinRouter = AddBitcoinRouter()
    
    init(interactor : AddBitcoinInteractorProtocol = AddBitcoinInteractor()) {
        self.interactor = interactor
    }
    
    func addBitcoin(amount: Float) {
        interactor.addBitcoin(amount:Float)
    }
    
    
}
