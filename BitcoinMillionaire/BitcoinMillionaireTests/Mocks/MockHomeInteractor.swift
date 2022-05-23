//
//  MockHomeInteractor.swift
//  BitcoinMillionaireTests
//
//  Created by Karan Bhasin on 19/05/22.
//

import Foundation
import Combine
@testable import BitcoinMillionaire

class MockHomeInteractor: HomeInteractorProtocol {
        
    var checkLatestBitcoinPriceInInteractorCalled: Bool = false
    var checkIfIAmAMillionaireInInteractorCalled: Bool = false
    var checkIfBitcoinAvailabilityInInteractorCalled: Bool = false
    
    func checkIfIAmAMillionaire() {
        checkIfIAmAMillionaireInInteractorCalled = true
    }
    
    func checkLatestBitcoinPrice() -> AnyPublisher<BitcoinPrice, Error> {
        checkLatestBitcoinPriceInInteractorCalled = true
        return Just(BitcoinPrice(code: "USD", symbol: "&#36", rate: "29,379.0384", description: "United States Dollar", rateFloat: 29379.0384))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func checkBitcoinAvailability() -> CurrentValueSubject<UserBitcoinEntity, Error> {
        checkIfBitcoinAvailabilityInInteractorCalled = true
        let currentValueSubject = CurrentValueSubject<UserBitcoinEntity, Error>(UserBitcoinEntity(initialCoins: 10.0))
        return currentValueSubject
    }

}
