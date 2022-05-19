//
//  MockHomeInteractor.swift
//  BitcoinMillionaireTests
//
//  Created by Karan Bhasin on 19/05/22.
//

import Foundation
@testable import BitcoinMillionaire

class MockHomeInteractor: HomeInteractorProtocol {
    
    var checkLatestBitcoinPriceInInteractorCalled: Bool = false
    var checkIfIAmAMillionaireInInteractorCalled: Bool = false
    
    
    func checkLatestBitcoinPrice() {
        checkLatestBitcoinPriceInInteractorCalled = true
    }
    
    func checkIfIAmAMillionaire() {
        checkIfIAmAMillionaireInInteractorCalled = true
    }

}
