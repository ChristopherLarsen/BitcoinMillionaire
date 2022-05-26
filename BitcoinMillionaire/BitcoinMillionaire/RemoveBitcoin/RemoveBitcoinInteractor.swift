//
//  RemoveBitcoinInteractor.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation

protocol RemoveBitcoinInteractorProtocol {
    func removeBitcoin(amount: Double) -> Result<Bool,Error>
}

class RemoveBitcoinInteractor : RemoveBitcoinInteractorProtocol {
    
    func removeBitcoin(amount: Double) -> Result<Bool, Error> {
        self.userBitcoinService.removeBitcoin(amountToRemove: amount)
    }
    
    var userBitcoinService: UserBitcoinServiceProtocol
    
    init(userBitcoinService: UserBitcoinServiceProtocol = UserBitcoinService(database: DatabaseService(userDefaults: BitcoinUserDefaults()))) {
        self.userBitcoinService = userBitcoinService
    }
}

