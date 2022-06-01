//
//  UserBitcoinServiceTests.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-19.
//

import XCTest
import Combine
import ReSwift
@testable import BitcoinMillionaire


class UserBitcoinServiceTests: XCTestCase {
    
    var mockBitcoinUserDefaults: MockBitcoinUserDefaults!
    var mockDatabase: MockDatabase!
    var mockStoreSubscriber: MockStoreSubscriber!
    
    var sut: UserBitcoinServiceProtocol!
    
    var testStore: Store<State>!
    
    override func setUpWithError() throws {
        
        let initialState = State(message: "",
                                 bitcoinState: BitcoinState(),
                                 priceState: PriceState() )
        
        testStore = Store<State>(
            reducer: reducer,
            state: initialState
        )
        
        mockBitcoinUserDefaults = MockBitcoinUserDefaults()
        mockDatabase = MockDatabase(userDefaults: mockBitcoinUserDefaults)
        mockStoreSubscriber = MockStoreSubscriber()
        sut = UserBitcoinService(store: testStore)
        
        testStore.subscribe(mockStoreSubscriber)
    }
    
    override func tearDownWithError() throws {
        
        mockBitcoinUserDefaults = nil
        mockDatabase = nil
        mockStoreSubscriber = nil
        sut = nil
        
    }
    
    func testUserBitcoinService_WhenBitcoinAdded_ShouldCallStoreToDispatch() {
        // TODO: Need a mock Store
    }
    
    func testUserBitcoinService_WhenBitcoinAdded_ShouldUpdateTheStore() {
        
        // Arrange
        
        let expectation = expectation(description: "Should update the Store")
        
        let previousBitcoins: Double = testStore.state.bitcoinState.bitcoin
        let bitcoinsToAdd: Double = Double.random(in: 0...1.0).roundedToEightDigits
        let expectedBitcoinsAfterAddingBitcoins = previousBitcoins + bitcoinsToAdd
        
        mockStoreSubscriber.expection = expectation
        
        // Act
        
        let result = sut.addBitcoin(amountToAdd: bitcoinsToAdd)
        
        // Assert
        
        switch result {
        case .success:              print("Added Bitcoin")
        case .failure(let error):   XCTFail("Failed - Unable to perform Add Bitcoin operation \(error)")
        }
        
        waitForExpectations(timeout: 1.0) { [weak self] error in
            
            guard let self = self else {
                XCTFail("Failed - Test Error")
                return
            }
            
            guard error == nil else {
                XCTFail("Failed - Test Error")
                return
            }

            let bitcoinsAfterAdding: Double = self.testStore.state.bitcoinState.bitcoin
            
            XCTAssertTrue(bitcoinsAfterAdding == expectedBitcoinsAfterAddingBitcoins, "Failed - Did not add the correct amount of Bitcoin.")

        }
        
    }
    
    func testUserBitcoinService_WhenTooManyBitcoinRemoved_ShouldReturnAnError() {
        
        // Arrange

        let initialBitcoin = testStore.state.bitcoinState.bitcoin
        let bitcoinsToRemove: Double = initialBitcoin + 1.0
        let expectedBitcoinsAfterRemovingBitcoins = initialBitcoin
        
        // Act
        
        let result = sut.removeBitcoin(amountToRemove: bitcoinsToRemove)
        
        // Assert
        
        switch result {
        case .success:
            XCTFail("Failed - Succeeded in removing Bitcoin when there wasn't enough Bitcoin to remove.")
        case .failure(_):
            XCTAssertTrue(true, "Failed - Expect an insufficient Bitcoin error")
        }
        
        let bitcoinsAfterRemoving: Double = testStore.state.bitcoinState.bitcoin
        
        XCTAssertTrue(bitcoinsAfterRemoving == expectedBitcoinsAfterRemovingBitcoins, "Failed - Should not have changed the amount of Bitcoin.")
        
    }
    
    func testUserBitcoinService_BitcoinError_HasLocalizedDescription() {
        
        XCTAssertTrue(UserBitcoinServiceError.unknownError.localizedDescription?.count ?? 0 > 0, "Failed - Missing Localized description for unknownError.")
        XCTAssertTrue(UserBitcoinServiceError.cannotAddZeroOrNegativeAmount.localizedDescription?.count ?? 0 > 0, "Failed - Missing Localized description for cannotAddZeroOrNegativeAmount.")
        XCTAssertTrue(UserBitcoinServiceError.insufficientBitcoinToRemove.localizedDescription?.count ?? 0 > 0, "Failed - Missing Localized description for insufficientBitcoinToRemove.")
        
    }
    
}
