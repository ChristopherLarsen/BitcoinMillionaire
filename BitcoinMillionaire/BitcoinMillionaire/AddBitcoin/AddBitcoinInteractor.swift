//
//  AddBitcoinInteractor.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation

protocol AddBitcoinInteractorProtocol {
    func addBitcoin(amount:Float) -> Result<Bool,Error>
}

class AddBitcoinInteractor : AddBitcoinInteractorProtocol {
    
    var userBitcoinService: UserBitcoinServiceProtocol
    
    init(userBitcoinService: UserBitcoinServiceProtocol = UserBitcoinService(database: DatabaseService(userDefaults: BitcoinUserDefaults()))) {
        self.userBitcoinService = userBitcoinService
    }
    
    func addBitcoin(amount:Float) -> Result<Bool,Error> {
        return self.userBitcoinService.addBitcoin(amountToAdd: amount)
    }
}

