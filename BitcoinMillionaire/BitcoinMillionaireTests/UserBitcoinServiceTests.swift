//
//  UserBitcoinServiceTests.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-19.
//

import XCTest
@testable import BitcoinMillionaire


class UserBitcoinServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserBitcoinService_WhenCreated_HasNoUserBitcoin() {
        
        let sut = UserBitcoinService()
        
        let UserBitcoinEntity: UserBitcoinEntity? = sut.userBitcoin()
        
        XCTAssertNil(UserBitcoinEntity, "Failed - There should not be any UserBitcoin when first created.")
        
    }

}
