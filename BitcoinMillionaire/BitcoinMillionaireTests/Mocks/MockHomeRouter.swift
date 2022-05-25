//
//  MockHomeRouter.swift
//  BitcoinMillionaireTests
//
//  Created by Karan Bhasin on 19/05/22.
//

import Foundation
@testable import BitcoinMillionaire

class MockHomeRouter: HomeRouterProtocol {
    
    var addBitcoinViewOpened: Bool = false
    var sellBitcoinViewOpened: Bool = false
    var checkMillionaireViewOpened: Bool = false
    
    func openAddBitcoinView() {
        addBitcoinViewOpened = true
    }
    
    func openSellBitcoinView() {
        sellBitcoinViewOpened = true
    }
    
    func openMillionaireView() {
        checkMillionaireViewOpened = true
    }
    
}
