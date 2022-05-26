//
//  MockBitCoinPriceService.swift
//  BitcoinMillionaireTests
//
//  Created by Karan Bhasin on 26/05/22.
//

import Foundation
import Combine
@testable import BitcoinMillionaire

class MockBitcoinPriceService: BitcoinPriceServiceProtocol {
    var latestPriceFromPriceServiceIsCalled: Bool = false
    var latestPriceFromDatabaseIsCalled: Bool = false

    func getLatest() -> AnyPublisher<BitcoinPrice, Error> {
        latestPriceFromPriceServiceIsCalled = true
        return Just(BitcoinPrice(code: "USD", symbol: "&amp;#36;", rate: "29379.0384", description: "United States Dollar", rateFloat: 29287.7669))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getLatestFromDataBase() -> AnyPublisher<Double, Error> {
        latestPriceFromDatabaseIsCalled = true
        return Just(29297.7669)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    
}
