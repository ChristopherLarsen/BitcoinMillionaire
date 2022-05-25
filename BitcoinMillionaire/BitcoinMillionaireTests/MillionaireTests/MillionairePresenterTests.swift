//
//  MillionairePresenterTests.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-24.
//

import XCTest
@testable import BitcoinMillionaire


class MillionairePresenterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMillionairePresenter_WhenCreated_HasReferencesToMillionaireViewController() {
        
        // Arrange

        let mockMillionaireInteractor = MockMillionaireInteractor()
        let mockMillionaireRouter = MockMillionaireRouter()
        
        // Act

        let sut = MillionairePresenter(interactor: mockMillionaireInteractor, router: mockMillionaireRouter)

        // Assert

        XCTAssertNotNil(sut.millionaireInteractor, "Failed - Expected MillionairePresenter to have a Interactor.")
        XCTAssertNotNil(sut.millionaireRouter, "Failed - Expected MillionairePresenter to have a Router.")
        
    }
    
    func testMillionairePresenter_WhenCreated_AssignsReferenceOnInteractor() {
        
        // Arrange

        let mockMillionaireInteractor = MockMillionaireInteractor()
        let mockMillionaireRouter = MockMillionaireRouter()
        
        // Act

        let sut = MillionairePresenter(interactor: mockMillionaireInteractor, router: mockMillionaireRouter)

        // Assert

        XCTAssertNotNil(sut.millionaireInteractor.millionairePresenter, "Failed - Expected MillionairePresenter to assign a reference back to MillionairePresenter.")
        XCTAssertNotNil(sut.millionaireRouter, "Failed - Expected MillionairePresenter to have a Router.")
        
    }

    func testMillionairePresenter_WhenCalledToCheckMillionaireByPresenter_ShouldCallInteractorToCalculatedUserMillionaire() {
        
        // Arrange

        let mockMillionaireInteractor = MockMillionaireInteractor()
        let mockMillionaireRouter = MockMillionaireRouter()
        
        // Act

        let sut = MillionairePresenter(interactor: mockMillionaireInteractor, router: mockMillionaireRouter)
        sut.checkIfUserIsBitcoinMillionaire()
        
        // Assert

        XCTAssertTrue(mockMillionaireInteractor.isCalledCalculateUserBitcoinMillionaireStatus, "Failed - Expected call to CalculateUserBitcoinMillionaireStatus.")
        
    }
    
}
