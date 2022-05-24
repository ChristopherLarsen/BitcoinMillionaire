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
    
    func checkLatestBitcoinPrice() -> AnyPublisher<Double, Error> {
        checkLatestBitcoinPriceInInteractorCalled = true
        return Just(29379.0384)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func checkLatestPriceFromDataBase() -> AnyPublisher<Double, Error> {
        checkLatestBitcoinPriceInInteractorCalled = true
        return Just(0.0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func checkBitcoinAvailability() -> CurrentValueSubject<UserBitcoinEntity, Error> {
        checkIfBitcoinAvailabilityInInteractorCalled = true
        let currentValueSubject = CurrentValueSubject<UserBitcoinEntity, Error>(UserBitcoinEntity(initialCoins: 10.0))
        return currentValueSubject
    }

}
