//
//  UserBitcoinServiceTests.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-19.
//

import XCTest
@testable import BitcoinMillionaire


class UserBitcoinServiceTests: XCTestCase {
    
    let mockUserDefaults: UserDefaultsProtocol = MockUserDefaults()
    var sut: UserBitcoinService!
    
    override func setUpWithError() throws {
        
        let mockDatabase = MockDatabase(userDefaults: mockUserDefaults)
        sut = UserBitcoinService(database: mockDatabase)
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUserBitcoinService_WhenCreated_HasNoUserBitcoin() {
        
        // Assert
        
        let cancellable = sut.currentUserBitcoins.sink { error in
            XCTFail("Should not have received an Error from the UserBitcoin publisher. Error: \(error)")
        } receiveValue: { userBitcoinEntity in
            print("success!")
            XCTAssertTrue(userBitcoinEntity.bitcoins == 0.0, "")
        }
        
        XCTAssertNotNil(cancellable, "Failed - The Publisher should have provided a cancellable.")
        
    }
    
    func testUserBitcoinService_AfterCreation_ShouldFetchLatestSavedUserBitcoinFromDatabase() {
        
        // Arrange
        
        // Insert a random number of Bitcoins to start
        //
        let initialNumberOfBitcoins = Float.random(in: 0...1.0)
        let userBitcoinEntity = UserBitcoinEntity(initialCoins: initialNumberOfBitcoins)

        mockUserDefaults.set(userBitcoinEntity, forKey: Constants.keyUserBitcoin)
        let mockDatabase = MockDatabase(userDefaults: mockUserDefaults)

        sut = UserBitcoinService(database: mockDatabase)

        // Assert
        
        let numberOfBitcoinsWhenCreated = sut.currentUserBitcoins.value.bitcoins

        XCTAssertTrue(numberOfBitcoinsWhenCreated == initialNumberOfBitcoins, "Failed - Service did not start with the number of Bitcoins in the Database")
    }
    
    func testUserBitcoinService_WhenBitcoinChanges_ShouldPublishToSubscribers() {
        
        // Arrange
        
        let expectation = self.expectation(description: "UserBitcoin changed")
        
        let cancellable = sut.currentUserBitcoins.sink { error in
            XCTFail("Should not have received an Error from the UserBitcoin publisher. Error: \(error)")
        } receiveValue: { userBitcoinEntity in
            if userBitcoinEntity.bitcoins == 1.0 {
                expectation.fulfill()
            }
        }
        
        // Act
        
        let result = sut.addBitcoin(amountToAdd: 1.0)
        
        switch result {
        case .success:              print("Added Bitcoin")
        case .failure(let error):   XCTFail("Unable to perform Add Bitcoin operation \(error)")
        }
        
        // Assert
        
        XCTAssertNotNil(cancellable, "Failed - The Publisher should have provided a cancellable.")
        
        self.waitForExpectations(timeout: 1.0)
        
    }
    
    func testUserBitcoinService_WhenBitcoinAdded_ShouldUpdateUserBitcoinEntity() {
        
        // Arrange
        
        let previousBitcoins: Float = sut.currentUserBitcoins.value.bitcoins
        let bitcoinsToAdd: Float = Float.random(in: 0...1.0)
        let expectedBitcoinsAfterAddingBitcoins = previousBitcoins + bitcoinsToAdd
        
        // Act
        
        let result = sut.addBitcoin(amountToAdd: bitcoinsToAdd)
        
        // Assert
        
        switch result {
        case .success:              print("Added Bitcoin")
        case .failure(let error):   XCTFail("Failed - Unable to perform Add Bitcoin operation \(error)")
        }
        
        let bitcoinsAfterAdding: Float = sut.currentUserBitcoins.value.bitcoins
        
        XCTAssertTrue(bitcoinsAfterAdding == expectedBitcoinsAfterAddingBitcoins, "Failed - Did not add the correct amount of Bitcoin.")
        
    }
    
    func testUserBitcoinService_WhenBitcoinRemoved_ShouldUpdateUserBitcoinEntity() {
        
        // Arrange
        
        let initialCoins: Float = 1.0 + Float.random(in: 0...1.0)
        
        sut.currentUserBitcoins.value = UserBitcoinEntity(initialCoins: initialCoins)
        
        let bitcoinsToRemove: Float = Float.random(in: 0...1.0)
        let expectedBitcoinsAfterRemovingBitcoins = initialCoins - bitcoinsToRemove
        
        // Act
        
        let result = sut.removeBitcoin(amountToRemove: bitcoinsToRemove)
        
        // Assert
        
        switch result {
        case .success:              print("Added Bitcoin")
        case .failure(let error):   XCTFail("Failed - Unable to perform Add Bitcoin operation \(error)")
        }
        
        let bitcoinsAfterRemoving: Float = sut.currentUserBitcoins.value.bitcoins
        
        XCTAssertTrue(bitcoinsAfterRemoving == expectedBitcoinsAfterRemovingBitcoins, "Failed - Did not add the correct amount of Bitcoin.")
        
    }
    
    func testUserBitcoinService_WhenTooManyBitcoinRemoved_ShouldReturnAnError() {
        
        // Arrange
        
        let initialCoins: Float = Float.random(in: 0...1.0)
        
        sut.currentUserBitcoins.value = UserBitcoinEntity(initialCoins: initialCoins)
        
        let bitcoinsToRemove: Float = 1.0 + Float.random(in: 0...1.0)
        let expectedBitcoinsAfterRemovingBitcoins = initialCoins
        
        // Act
        
        let result = sut.removeBitcoin(amountToRemove: bitcoinsToRemove)
        
        // Assert
        
        switch result {
        case .success:
            XCTFail("Failed - Succeeded in removing Bitcoin when there wasn't enough Bitcoin to remove.")
        case .failure(let error):
            XCTAssertTrue(error == .insufficientBitcoinToRemove, "Failed - Expect an insufficient Bitcoin error")
        }
        
        let bitcoinsAfterRemoving: Float = sut.currentUserBitcoins.value.bitcoins
        
        XCTAssertTrue(bitcoinsAfterRemoving == expectedBitcoinsAfterRemovingBitcoins, "Failed - Should not have changed the amount of Bitcoin.")
        
    }
    
}
