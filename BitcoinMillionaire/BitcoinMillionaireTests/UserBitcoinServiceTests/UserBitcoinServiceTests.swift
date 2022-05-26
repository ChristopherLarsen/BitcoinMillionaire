//
//  UserBitcoinServiceTests.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-19.
//

import XCTest
import Combine
@testable import BitcoinMillionaire


class UserBitcoinServiceTests: XCTestCase {
    
    var mockBitcoinUserDefaults: MockBitcoinUserDefaults!
    var mockDatabase: MockDatabase!
    var sut: UserBitcoinServiceProtocol!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        
        mockBitcoinUserDefaults = MockBitcoinUserDefaults()
        mockDatabase = MockDatabase(userDefaults: mockBitcoinUserDefaults)
        sut = UserBitcoinService(database: mockDatabase)
        
    }
    
    override func tearDownWithError() throws {
        mockBitcoinUserDefaults = nil
        mockDatabase = nil
        sut = nil
        cancellables = []
    }
    
    func testUserBitcoinService_WhenCreated_HasZeroUserBitcoin() {
        
        // Arrange

        mockBitcoinUserDefaults.clearUserDefaults()

        // Assert

        sut = UserBitcoinService(database: mockDatabase)

        let cancellable = sut.currentUserBitcoins.sink { error in
            XCTFail("Should not have received an Error from the UserBitcoin publisher. Error: \(error)")
        } receiveValue: { userBitcoinEntity in
            XCTAssertTrue(userBitcoinEntity.bitcoins == 0.0, "")
        }

        XCTAssertNotNil(cancellable, "Failed - The Publisher should have provided a cancellable.")
        
        guard let retrieveStoredBitcoinEntry = mockBitcoinUserDefaults.object(forKey: Key.keyUserBitcoin) else {
            XCTFail("Failed - Should have retrieved user bitcoin from mock user defaults.")
            return
        }
        
        if let retrievedUserBitcoinValue = retrieveStoredBitcoinEntry as? Float {
            XCTAssertTrue(retrievedUserBitcoinValue == 0.0, "Failed - Retrieved user bitcoin should have been zero.")
        } else {
            XCTFail("Failed - Should have retrieved user bitcoin from mock user defaults.")
        }
        
    }
    
    func testUserBitcoinService_AfterCreation_ShouldFetchLatestSavedUserBitcoinFromDatabase() {
        
        // Arrange
        
        // Insert a random number of Bitcoins to start
        //
        let initialNumberOfBitcoins = Double.random(in: 0...1.0)
        
        mockBitcoinUserDefaults.set(initialNumberOfBitcoins, forKey: Key.keyUserBitcoin)
        let mockDatabase = MockDatabase(userDefaults: mockBitcoinUserDefaults)

        // Act
        
        sut = UserBitcoinService(database: mockDatabase)

        // Assert
        
        let cancellable = sut.currentUserBitcoins.sink { error in
            XCTFail("Should not have received an Error from the UserBitcoin publisher. Error: \(error)")
        } receiveValue: { userBitcoinEntity in
            let numberOfBitcoinsWhenCreated = userBitcoinEntity.bitcoins
            XCTAssertTrue(numberOfBitcoinsWhenCreated == initialNumberOfBitcoins, "Failed - Initial bitcoins \(numberOfBitcoinsWhenCreated) did not start with the expected \(initialNumberOfBitcoins) number of Bitcoins in the Database")
        }
        
        XCTAssertNotNil(cancellable, "Failed to recieve cancellable from the Publisher")
        
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
        
        let previousBitcoins: Double = sut.currentUserBitcoins.value.bitcoins
        let bitcoinsToAdd: Double = Double.random(in: 0...1.0)
        let expectedBitcoinsAfterAddingBitcoins = previousBitcoins + bitcoinsToAdd
        
        // Act
        
        let result = sut.addBitcoin(amountToAdd: bitcoinsToAdd)
        
        // Assert
        
        switch result {
        case .success:              print("Added Bitcoin")
        case .failure(let error):   XCTFail("Failed - Unable to perform Add Bitcoin operation \(error)")
        }
        
        let bitcoinsAfterAdding: Double = sut.currentUserBitcoins.value.bitcoins
        
        XCTAssertTrue(bitcoinsAfterAdding == expectedBitcoinsAfterAddingBitcoins, "Failed - Did not add the correct amount of Bitcoin.")
        
    }
    
    func testUserBitcoinService_WhenBitcoinRemoved_ShouldUpdateUserBitcoinEntity() {
        
        // Arrange
        
        let initialCoins: Double = 1.0 + Double.random(in: 0...1.0)
        
        sut.currentUserBitcoins.value = UserBitcoinEntity(initialCoins: initialCoins)
        
        let bitcoinsToRemove: Double = Double.random(in: 0...1.0)
        let expectedBitcoinsAfterRemovingBitcoins = initialCoins - bitcoinsToRemove
        
        // Act
        
        let result = sut.removeBitcoin(amountToRemove: bitcoinsToRemove)
        
        // Assert
        
        switch result {
        case .success:              print("Added Bitcoin")
        case .failure(let error):   XCTFail("Failed - Unable to perform Add Bitcoin operation \(error)")
        }
        
        let bitcoinsAfterRemoving: Double = sut.currentUserBitcoins.value.bitcoins
        
        XCTAssertTrue(bitcoinsAfterRemoving == expectedBitcoinsAfterRemovingBitcoins, "Failed - Did not add the correct amount of Bitcoin.")
        
    }
    
    func testUserBitcoinService_WhenTooManyBitcoinRemoved_ShouldReturnAnError() {
        
        // Arrange
        
        let initialCoins: Double = Double.random(in: 0...1.0)
        
        sut.currentUserBitcoins.value = UserBitcoinEntity(initialCoins: initialCoins)
        
        let bitcoinsToRemove: Double = 1.0 + Double.random(in: 0...1.0)
        let expectedBitcoinsAfterRemovingBitcoins = initialCoins
        
        // Act
        
        let result = sut.removeBitcoin(amountToRemove: bitcoinsToRemove)
        
        // Assert
        
        switch result {
        case .success:
            XCTFail("Failed - Succeeded in removing Bitcoin when there wasn't enough Bitcoin to remove.")
        case .failure(_):
            XCTAssertTrue(true, "Failed - Expect an insufficient Bitcoin error")
        }
        
        let bitcoinsAfterRemoving: Double = sut.currentUserBitcoins.value.bitcoins
        
        XCTAssertTrue(bitcoinsAfterRemoving == expectedBitcoinsAfterRemovingBitcoins, "Failed - Should not have changed the amount of Bitcoin.")
        
    }
    
    func testUserBitcoinService_WhenAddingBitcoin_HasMoreBitcoin() {
        
        // Arrange

        let initialBitcoin = Double.random(in: 0...1.0)
        let addedBitcoin = Double.random(in: 0...1.0)
        let accuracy: Double = 0.000001
        let expectedBitcoin = initialBitcoin + addedBitcoin

        mockBitcoinUserDefaults.clearUserDefaults()
        
        let resultCreate = mockDatabase.create(key: Key.keyUserBitcoin, object: initialBitcoin)
        
        guard resultCreate == .success(true) else {
            XCTFail("Failed - MockDatabase operation error. ")
            return
        }

        sut = UserBitcoinService(database: mockDatabase)
        
        // Act

        let result = sut.addBitcoin(amountToAdd: addedBitcoin)

        // Assert
        
        switch result {
        case .success(_): break
        case .failure(let error) :
            XCTFail(error.localizedDescription)
        }
        
        let cancellable = sut.currentUserBitcoins.sink { error in
            XCTFail("Should not have received an Error from the UserBitcoin publisher. Error: \(error)")
        } receiveValue: { userBitcoinEntity in
            XCTAssertEqual(userBitcoinEntity.bitcoins, expectedBitcoin, accuracy: accuracy, "Failed - Received \(userBitcoinEntity.bitcoins) bitcoins instead of \(expectedBitcoin) bitcoins.")
        }
        
        XCTAssertNotNil(cancellable, "Failed - The Publisher should have provided a cancellable.")

        guard let retrievedUserBitcoinValue = mockBitcoinUserDefaults.object(forKey: Key.keyUserBitcoin) as? Double else {
            XCTFail("Failed - Should have retrieved user bitcoin from mock user defaults.")
            return
        }
        
        XCTAssertEqual(retrievedUserBitcoinValue, expectedBitcoin, accuracy: accuracy, "Failed - Retrieved user bitcoin: \(retrievedUserBitcoinValue) should have been expected amount: \(expectedBitcoin)")
        
    }
    
    func testUserBitcoinService_BitcoinError_HasLocalizedDescription() {
        
        XCTAssertTrue(UserBitcoinServiceError.unknownError.localizedDescription?.count ?? 0 > 0, "Failed - Missing Localized description for unknownError.")
        XCTAssertTrue(UserBitcoinServiceError.cannotAddZeroOrNegativeAmount.localizedDescription?.count ?? 0 > 0, "Failed - Missing Localized description for cannotAddZeroOrNegativeAmount.")
        XCTAssertTrue(UserBitcoinServiceError.insufficientBitcoinToRemove.localizedDescription?.count ?? 0 > 0, "Failed - Missing Localized description for insufficientBitcoinToRemove.")
        
    }
    
    func testUserBitcoinService_WhenRemovingBitcoin_HasLessBitcoin() {
        
        // Arrange

        let initialBitcoin = 1 + Double.random(in: 0...1.0)
        let removedBitcoin = Double.random(in: 0...1.0)
        let accuracy: Double = 0.000001
        let expectedBitcoin = initialBitcoin - removedBitcoin

        mockBitcoinUserDefaults.clearUserDefaults()
        
        let resultCreate = mockDatabase.create(key: Key.keyUserBitcoin, object: initialBitcoin)
        
        guard resultCreate == .success(true) else {
            XCTFail("Failed - MockDatabase operation error. ")
            return
        }

        sut = UserBitcoinService(database: mockDatabase)
        
        // Act

        let result = sut.removeBitcoin(amountToRemove: removedBitcoin)

        // Assert
        switch result {
        case .failure(_) : XCTFail("Failed - BitcoinsService operation error. ")
        case .success(_) :  break
        }
                
        let cancellable = sut.currentUserBitcoins.sink { error in
            XCTFail("Should not have received an Error from the UserBitcoin publisher. Error: \(error)")
        } receiveValue: { userBitcoinEntity in
            XCTAssertEqual(userBitcoinEntity.bitcoins, expectedBitcoin, accuracy: accuracy, "Failed - Received \(userBitcoinEntity.bitcoins) bitcoins instead of \(expectedBitcoin) bitcoins.")
        }
        
        XCTAssertNotNil(cancellable, "Failed - The Publisher should have provided a cancellable.")

        guard let retrievedUserBitcoinValue = mockBitcoinUserDefaults.object(forKey: Key.keyUserBitcoin) as? Double else {
            XCTFail("Failed - Should have retrieved user bitcoin from mock user defaults.")
            return
        }
        
        XCTAssertEqual(retrievedUserBitcoinValue, expectedBitcoin, accuracy: accuracy, "Failed - Retrieved user bitcoin: \(retrievedUserBitcoinValue) should have been expected amount: \(expectedBitcoin)")
        
    }
    
    func testUserBitcoinService_WhenCreated_ShouldSubscribeToChangesInUserBitcoin() {
        
        // Arrange

        let expection = self.expectation(description: "Should recieve Notification")
        var isNotificationRecieved = false

        mockBitcoinUserDefaults.clearUserDefaults()
        sut = UserBitcoinService(database: mockDatabase)
        
        NotificationCenter.default.publisher(for: .userBitcoinChanged).sink { notification in
            isNotificationRecieved = true
            expection.fulfill()
        }.store(in: &cancellables)
        
        // Act
        
        _ = sut.addBitcoin(amountToAdd: 1.0)
        
        // Assert

        self.waitForExpectations(timeout: 1.0) { error in
            
            guard error == nil else {
                return
            }
            
            XCTAssertTrue(isNotificationRecieved, "Failed - Did not recieve userBitcoinChanged Notification.")
        }
        
    }
    
    func testUserBitcoinService_WhenOneIsChanged_ShouldChangeForAllSeriveObjects() {
        
        // Arrange

        let expection1 = self.expectation(description: "UserBitcoinServices")
        var isNotificationRecieved = false

        let userBitcoinService1 = UserBitcoinService(database: mockDatabase)
        let userBitcoinService2 = UserBitcoinService(database: mockDatabase)

        NotificationCenter.default.publisher(for: .userBitcoinChanged).sink { notification in
            guard let obj = notification.object as? UserBitcoinService else {
                return
            }
            if obj === userBitcoinService2 {
                isNotificationRecieved = true
                expection1.fulfill()
            }
        }.store(in: &cancellables)
        
        // Act
        
        _ = userBitcoinService1.addBitcoin(amountToAdd: 1.0)
        
        // Assert

        self.waitForExpectations(timeout: 1.0) { error in
            
            guard error == nil else {
                return
            }
            
            XCTAssertTrue(isNotificationRecieved, "Failed - Did not recieve userBitcoinChanged Notification.")
            
            let bitcoin1 = userBitcoinService1.currentUserBitcoins.value.bitcoins
            let bitcoin2 = userBitcoinService2.currentUserBitcoins.value.bitcoins
            
            XCTAssertTrue(bitcoin1 == bitcoin2, "Failed - UserBitcoinServices out of sync. \(bitcoin1) \(bitcoin2)")

        }
        
    }
    
}
