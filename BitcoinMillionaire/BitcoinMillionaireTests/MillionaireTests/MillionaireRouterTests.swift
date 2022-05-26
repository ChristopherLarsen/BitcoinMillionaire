//
//  MillionaireRouterTests.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-25.
//

import XCTest
@testable import BitcoinMillionaire


// MARK: - MillionaireRouterTests

class MillionaireRouterTests: XCTestCase {

    var sut: MillionaireRouter!
    
    override func setUpWithError() throws {
        sut = MillionaireRouter()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMillionaireRouter_WhenCreated_ShouldHaveAssignablePresenter(){
        
        // Arrange

        let mockMillionairePresenter = MockMillionairePresenter()
        
        // Act
        
        sut.millionairePresenter = mockMillionairePresenter

        // Assert

        XCTAssertNotNil(sut.millionairePresenter, "Failed - MillionairePresenter not assignable.")
        
    }

    func testMillionaireRouter_WhenCalledNavigateBack_ShouldReturnToHomeScreen(){
        
        // Arrange

        let mockMillionairePresenter = MockMillionairePresenter()
        sut.millionairePresenter = mockMillionairePresenter
        
        // Act
        
        sut.navigateBack()
        
        // Assert

        XCTAssertTrue(mockMillionairePresenter.isCalledMillionaireViewController, "Failed - Should have called for the Presenters ViewController.")
        
    }

}
