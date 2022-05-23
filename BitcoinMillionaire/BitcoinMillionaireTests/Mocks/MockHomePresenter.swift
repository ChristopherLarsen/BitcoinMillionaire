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
    var addBitcoinCalled: Bool = false
    var sellBitcoinCalled: Bool = false
    var checkLatestBitcoinPriceCalled: Bool = false
    var checkIfIAmAMillionaireCalled: Bool = false

    required init(interactor: HomeInteractorProtocol, router: HomeRouterProtocol = MockHomeRouter()) {
        self.interactor = interactor
        self.router = router
    }
    
    func addBitcoin() {
        addBitcoinCalled = true
    }
    
    func sellBitcoin() {
        sellBitcoinCalled = true
    }
    func checkLatestBitcoinPrice() {
        checkLatestBitcoinPriceCalled = true
    }
    
    func checkIfIAmAMillionaire() {
        checkIfIAmAMillionaireCalled = true
    }
    
    func checkNumberOfCoinsAvailable() {
        
    }
    
}
