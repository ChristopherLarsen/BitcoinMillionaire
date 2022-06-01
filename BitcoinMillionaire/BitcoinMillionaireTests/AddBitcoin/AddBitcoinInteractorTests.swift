//
//  AddBitcoinInteractorTests.swift
//  BitcoinMillionaireTests
//
//  Created by Jorge Mattei on 5/26/22.
//

import XCTest
import ReSwift
@testable import BitcoinMillionaire


class AddBitcoinInteractorTests: XCTestCase {
    
    var testStore: Store<State>!

    override func setUpWithError() throws {
    
        let initialState = State(message: "",
                                 bitcoinState: BitcoinState(),
                                 priceState: PriceState() )
        
        testStore = Store<State>(
            reducer: reducer,
            state: initialState
        )

    }

    override func tearDownWithError() throws {
    }
    
    func testAddBitcoinInteractor_WhenAddingPositiveAmountOfBitcoin_ShouldReturnTrue() throws {
        //Arrange
        let service = UserBitcoinService()
        let sut = AddBitcoinInteractor(userBitcoinService: service)
        //Act
        let amount : Double = 1.0
        let result = sut.addBitcoin(amount: amount)
        //Assert
        switch result {
        case .success(let success): XCTAssert(success)
        case .failure(let error) : XCTFail(error.localizedDescription)
        }
    }
    
    func testAddBitcoinInteractor_WhenGivingANegativeAmoungOfBitcoin_ShouldThrowError() throws {
        //Arrange
        let service = UserBitcoinService(store: testStore)
        let sut = AddBitcoinInteractor(userBitcoinService: service)
        //Act
        let amount : Double = -1.0
        let result = sut.addBitcoin(amount: amount)
        //Assert
        switch result {
        case .success(_): XCTFail("Should throw Error")
        case .failure(_) :XCTAssert(true, "Should throw Error")
        }
    }
    
    func testAddBitcoinInteractor_WhenGivingZeroBitcoin_ShouldThrowError() throws {
        //Arrange
        let service = UserBitcoinService(store: testStore)
        let sut = AddBitcoinInteractor(userBitcoinService: service)
        //Act
        let amount : Double = 0.0
        let result = sut.addBitcoin(amount: amount)
        //Assert
        switch result {
        case .success(_): XCTFail("Should throw Error")
        case .failure(_) :XCTAssert(true, "Should throw Error")
        }
    }

}
