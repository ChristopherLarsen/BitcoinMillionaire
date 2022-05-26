//
//  MillionaireInteractorTests.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-24.
//

import XCTest
@testable import BitcoinMillionaire


class MillionaireInteractorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMillionaireInteractor_WhenCreated_HasReferencesToMillionairePresenter() {
        
        // Arrange

        let mockMillionairePresenter = MockMillionairePresenter()
        
        // Act

        let sut = MillionaireInteractor()
        sut.millionairePresenter = mockMillionairePresenter

        // Assert

        XCTAssertNotNil(sut.millionairePresenter, "Failed - Expected MillionaireInteractor to have a Presenter reference.")
        
    }
    
    func testMillionaireInteractor_WhenCalculatingBitcoinValue_ShouldReturnCorrectValue() {
        
        // Arrange

        let mockMillionairePresenter = MockMillionairePresenter()
        
        // Act

        let sut = MillionaireInteractor()
        sut.millionairePresenter = mockMillionairePresenter

        let bitcoinPrice: Float = 30_000.0
        
        let calculatedBitcoinValue1 = sut.calculateCurrentBitcoinValue(forUserBitcoins: 24.0, bitcoinPrice: bitcoinPrice)
        let calculatedBitcoinValue2 = sut.calculateCurrentBitcoinValue(forUserBitcoins: 34.0, bitcoinPrice: bitcoinPrice)
        let calculatedBitcoinValue3 = sut.calculateCurrentBitcoinValue(forUserBitcoins: 44.0, bitcoinPrice: bitcoinPrice)

        // Assert

        XCTAssertEqual(calculatedBitcoinValue1, 720_000.0, accuracy: 0.001, "Failed - Incorrect value calculation. \(calculatedBitcoinValue1)")
        XCTAssertEqual(calculatedBitcoinValue2, 1_020_000.0, accuracy: 0.001, "Failed - Incorrect value calculation. \(calculatedBitcoinValue2)")
        XCTAssertEqual(calculatedBitcoinValue3, 1_320_000.0, accuracy: 0.001, "Failed - Incorrect value calculation. \(calculatedBitcoinValue3)")

    }
    
    func testMillionaireInteractor_WhenCalculatingMillionaireStatus_ShouldCallPresenterWithResult() {
        
        // Arrange

        let mockMillionairePresenter = MockMillionairePresenter()
        let sut = MillionaireInteractor()
        sut.millionairePresenter = mockMillionairePresenter
        
        // Act

        sut.calculateUserBitcoinMillionaireStatus()

        // Assert

        let isCalledCalculatedUser = mockMillionairePresenter.isCalledCalculatedUser
        
        XCTAssertTrue(isCalledCalculatedUser, "Failed - Interactor did not call Presenter with calculated status.")

    }

}
