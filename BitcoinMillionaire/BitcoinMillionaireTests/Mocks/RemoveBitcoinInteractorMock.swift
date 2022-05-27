//
//  RemoveBitcoinInteractorMock.swift
//  BitcoinMillionaireTests
//
//  Created by Rakesh Kumar on 2022-05-27.
//

import Foundation

@testable import BitcoinMillionaire

class RemoveBitcoinInteractorMock : RemoveBitcoinInteractorProtocol {
    
    var shouldThrowError : Bool
    
    init(shouldThrowError : Bool) {
        self.shouldThrowError = shouldThrowError
    }
    
    func removeBitcoin(amount: Double) -> Result<Bool, Error> {
        if shouldThrowError {
            return .failure(UserBitcoinServiceError.cannotAddZeroOrNegativeAmount)
        } else {
            return .success(true)
        }
    }
    
}
