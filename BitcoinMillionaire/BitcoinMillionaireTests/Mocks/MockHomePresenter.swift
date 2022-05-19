//
//  MockHomePresenter.swift
//  BitcoinMillionaireTests
//
//  Created by Karan Bhasin on 19/05/22.
//

import Foundation
@testable import BitcoinMillionaire

class MockHomePresenter: HomePresenterProtocol {
    
    var interactor: HomeInteractorProtocol
    var router: HomeRouterProtocol
    var addBitCoinInInteractorCalled: Bool = false
    var sellBitCoinInInteractorCalled: Bool = false
    var checkLatestBitcoinPriceInInteractorCalled: Bool = false
    var checkIfIAmAMillionaireInInteractorCalled: Bool = false

    required init(interactor: HomeInteractorProtocol, router: HomeRouterProtocol = MockHomeRouter()) {
        self.interactor = interactor
        self.router = router
    }
    
    func addBitCoin() {
        addBitCoinInInteractorCalled = true
    }
    
    func sellBitCoin() {
        sellBitCoinInInteractorCalled = true
    }
    func checkLatestBitcoinPrice() {
        checkLatestBitcoinPriceInInteractorCalled = true
    }
    
    func checkIfIAmAMillionaire() {
        checkIfIAmAMillionaireInInteractorCalled = false
    }
    
    
}
