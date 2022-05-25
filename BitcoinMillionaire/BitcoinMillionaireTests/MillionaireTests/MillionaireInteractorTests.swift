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

}
