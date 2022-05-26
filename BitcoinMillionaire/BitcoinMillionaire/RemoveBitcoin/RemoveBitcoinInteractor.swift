//
//  RemoveBitcoinInteractor.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation

protocol RemoveBitcoinInteractorProtocol {
    func removeBitcoin(amount: Double) throws
}

class RemoveBitcoinInteractor : RemoveBitcoinInteractorProtocol {
    
    var userBitcoinService: UserBitcoinServiceProtocol
    
    init(userBitcoinService: UserBitcoinServiceProtocol = UserBitcoinService(database: DatabaseService(userDefaults: BitcoinUserDefaults()))) {
        self.userBitcoinService = userBitcoinService
    }
    
    func removeBitcoin(amount: Double) throws {
        switch self.userBitcoinService.removeBitcoin(amountToRemove: amount) {
        case .success( _ ): break
        case .failure(let error) :
            throw error
        }
    }
}

