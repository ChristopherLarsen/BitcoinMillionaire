//
//  AddBitcoinInteractor.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation

protocol AddBitcoinInteractorProtocol {
    func addBitcoin(amount:Float) throws
}

class AddBitcoinInteractor : AddBitcoinInteractorProtocol {
    
    var userBitcoinService: UserBitcoinServiceProtocol
    
    init(userBitcoinService: UserBitcoinServiceProtocol = UserBitcoinService(database: DatabaseService(userDefaults: BitcoinUserDefaults()))) {
        self.userBitcoinService = userBitcoinService
    }
    
    func addBitcoin(amount:Float) throws {
        switch self.userBitcoinService.addBitcoin(amountToAdd: amount) {
        case .success( _ ): break
        case .failure(let error) :
            throw error
        }
        
    }
}

