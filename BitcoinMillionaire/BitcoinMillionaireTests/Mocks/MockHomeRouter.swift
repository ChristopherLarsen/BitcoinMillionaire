//
//  MockHomeRouter.swift
//  BitcoinMillionaireTests
//
//  Created by Karan Bhasin on 19/05/22.
//

import Foundation
@testable import BitcoinMillionaire

class MockHomeRouter: HomeRouterProtocol {
    var addBitCoinViewOpened: Bool = false
    var sellBitCoinViewOpened: Bool = false
    
    func openAddBitCoinView() {
        addBitCoinViewOpened = true
    }
    
    func openSellBitCoinView() {
        sellBitCoinViewOpened = true
    }
    
    
}
