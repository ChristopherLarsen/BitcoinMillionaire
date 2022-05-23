//
//  UserBitcoinTests.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-19.
//

import XCTest
@testable import BitcoinMillionaire


class UserBitcoinTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserBitcoin_WhenCreated_HasZeroBitcoins() {
    
        let initialCoins: Float = 0.0
        let sut = UserBitcoinEntity(initialCoins: initialCoins)
        XCTAssertTrue(sut.bitcoins == 0.0, "UserBitcoin should have been initialized with zero initial value.")
        
    }
    
    func testUserBitcoin_WhenCreatedWithPositiveBitcoins_HasPositiveBitcoins() {
    
        let initialCoins: Float = 1.0
        let sut = UserBitcoinEntity(initialCoins: initialCoins)
        XCTAssertTrue(sut.bitcoins == 1.0, "UserBitcoin should have been initialized with an initial value.")
        
    }
    
    func testUserBitcoin_WhenCreatedWithNegativeBitcoins_Bitcoins() {
    
        let initialCoins: Float = -1.0
        let sut = UserBitcoinEntity(initialCoins: initialCoins)
        XCTAssertTrue(sut.bitcoins == 0.0, "UserBitcoin should have been initialized with a zero initial value.")
        
    }

}
