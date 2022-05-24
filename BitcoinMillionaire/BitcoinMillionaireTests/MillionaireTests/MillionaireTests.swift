//
//  MillionaireTests.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-24.
//

import XCTest
@testable import BitcoinMillionaire


class MillionaireTests: XCTestCase {
    
    override func setUpWithError() throws {
                
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMillionaireView_WhenCreated_ShouldHavePresenterAndReferenceBackToViewController() {
        
        // Arrange

        let mockPresenter = MockMillionairePresenter()
        
        // Act
        
        let sut = MillionaireViewController(withPresenter: mockPresenter)
        
        // Assert

        XCTAssertNotNil(sut.millionairePresenter, "Failed - Presenter not created with MillionaireViewController.")
        XCTAssertNotNil(sut.millionairePresenter.millionaireViewController, "Failed - Presenter not supplied reference to MillionaireViewController.")

    }

}
