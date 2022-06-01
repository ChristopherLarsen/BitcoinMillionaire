//
//  BitcoinReducerTests.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-06-01.
//

import XCTest
import ReSwift
@testable import BitcoinMillionaire


class BitcoinReducerTests: XCTestCase {

    var testStore: Store<State>!

    var mockDatabaseService: MockDatabase!
    var mockStoreSubscriber: MockStoreSubscriber!

    let initialState = State(message: "",
                             bitcoinState: BitcoinState(bitcoin: 2.0),
                             priceState: PriceState() )

    override func setUpWithError() throws {
        
        testStore = Store<State>(
            reducer: reducer,
            state: initialState
        )
        
        mockDatabaseService = MockDatabase()
        mockStoreSubscriber = MockStoreSubscriber()
        testStore.subscribe(mockStoreSubscriber)
    }

    override func tearDownWithError() throws {
        testStore.unsubscribe(mockStoreSubscriber)
    }

    func testBitcoinReducer_WhenAddingBitcoin_ShouldAddCorrectly() throws {
        
        // Arrange

        let expectation = expectation(description: "Wait for state to update")
        
        mockStoreSubscriber.expection = expectation
        
        let amountToAdd = Double.random(in: 0...1).roundedToEightDigits
        let addBitcoinAction = BitcoinAction.addBitcoin(amount: amountToAdd)
        
        // Act

        testStore.dispatch(addBitcoinAction)
                
        // Assert

        let expectedAmountAfterAdding = initialState.bitcoinState.bitcoin + amountToAdd

        self.waitForExpectations(timeout: 1.0) { error in
            
            guard error == nil else {
                return
            }
            
            let bitcoin = self.testStore.state.bitcoinState.bitcoin
            
            XCTAssert(bitcoin == expectedAmountAfterAdding, "Failed - Bitcoin not added correctly. \(bitcoin) \(amountToAdd)")
        }
        
    }
    
    func testBitcoinReducer_WhenRemovingBitcoin_ShouldRemoveCorrectly() throws {
        
        // Arrange

        let expectation = expectation(description: "Wait for state to update")
        
        mockStoreSubscriber.expection = expectation
        
        let amountToRemove = Double.random(in: 0...1).roundedToEightDigits
        let removeBitcoinAction = BitcoinAction.removeBitcoin(amount: amountToRemove)
        
        // Act

        testStore.dispatch(removeBitcoinAction)
                
        // Assert

        let expectedAmountAfterRemoving = initialState.bitcoinState.bitcoin - amountToRemove

        self.waitForExpectations(timeout: 1.0) { error in
            
            guard error == nil else {
                return
            }
            
            let bitcoin = self.testStore.state.bitcoinState.bitcoin
            
            XCTAssert(bitcoin == expectedAmountAfterRemoving, "Failed - Bitcoin not removed correctly. \(bitcoin) \(amountToRemove)")
        }
        
    }
    
    func testBitcoinReducer_WhenRemovingTooManyBitcoin_ShouldNotRemoveBitcoin() throws {
        
        // Arrange

        let expectation = expectation(description: "Wait for state to update")
        
        mockStoreSubscriber.expection = expectation
        
        let amountToRemove = 2.0 + Double.random(in: 0...1).roundedToEightDigits
        let removeBitcoinAction = BitcoinAction.removeBitcoin(amount: amountToRemove)
        
        // Act

        testStore.dispatch(removeBitcoinAction)
                
        // Assert

        let expectedAmountAfterRemoving = initialState.bitcoinState.bitcoin

        self.waitForExpectations(timeout: 1.0) { error in
            
            guard error == nil else {
                return
            }
            
            let bitcoin = self.testStore.state.bitcoinState.bitcoin
            
            XCTAssert(bitcoin == expectedAmountAfterRemoving, "Failed - Bitcoin not removed correctly. \(bitcoin) \(amountToRemove)")
        }
        
    }
   
}
