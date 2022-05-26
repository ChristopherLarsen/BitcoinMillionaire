//
//  AddBitcoinInteractorMock.swift
//  BitcoinMillionaireTests
//
//  Created by Jorge Mattei on 5/26/22.
//

import Foundation
@testable import BitcoinMillionaire

class AddBitcoinInteractorMock : AddBitcoinInteractorProtocol {
    
    
    var shouldThrowError : Bool
    
    init(shouldThrowError : Bool) {
        self.shouldThrowError = shouldThrowError
    }
    
    
    func addBitcoin(amount: Float) -> Result<Bool, Error> {
        if shouldThrowError {
            return .failure(UserBitcoinServiceError.cannotAddZeroOrNegativeAmount)
        } else {
            return .success(true)
        }
    }
    
}
