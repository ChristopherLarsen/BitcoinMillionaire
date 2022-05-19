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
        
        let mockUserDefaults: UserDefaultsProtocol = MockUserDefaults()
        let mockDatabase = MockDatabase(userDefaults: mockUserDefaults)
        let sut = UserBitcoinService(database: mockDatabase)

        let cancellable = sut.currentUserBitcoins.sink { error in
            XCTFail("Should not have received an Error from the UserBitcoin publisher. Error: \(error)")
        } receiveValue: { userBitcoinEntity in
            print("success!")
            XCTAssertTrue(userBitcoinEntity.bitcoins == 0.0, "")
        }

        XCTAssertNotNil(cancellable, "Failed - The Publisher should have provided a cancellable.")
        
    }
    
    func testUserBitcoinService_WhenAddingBitcoing_HasUserBitcoin() {
        // TODO:
    }

}
