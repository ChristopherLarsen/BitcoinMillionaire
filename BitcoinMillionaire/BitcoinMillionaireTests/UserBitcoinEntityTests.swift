//
//  UserBitcoinEntityTests.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-19.
//

import XCTest
@testable import BitcoinMillionaire


class UserBitcoinEntityTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserBitcoinEntity_WhenInitialized_ShouldStoreTheInitialValue() {
        
        let userBitcoinEntity = UserBitcoinEntity(initialCoins: 1.0)
        XCTAssertTrue(userBitcoinEntity.bitcoins == 1.0, "Failed - UserBitcoinEntity did not store the initial value of Bitcoins.")
        
    }
    
    func testUserBitcoinEntity_WhenInitializedWithNegativeValue_ShouldStoreZeroValue() {
        
        let userBitcoinEntity = UserBitcoinEntity(initialCoins: -1.0)
        XCTAssertTrue(userBitcoinEntity.bitcoins == 0.0, "Failed - UserBitcoinEntity did not store a zero initial value for negative Bitcoins.")
        
    }

}
