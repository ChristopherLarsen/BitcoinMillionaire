//
//  MillionaireViewControllerTests.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-24.
//

import XCTest
@testable import BitcoinMillionaire


class MillionaireViewControllerTests: XCTestCase {
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
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
    
    func testMillionaireView_WhenCreated_ShouldHaveUIBindings() {
        
        // Arrange

        let mockPresenter = MockMillionairePresenter()
        
        // Act
        
        let sut = MillionaireViewController(withPresenter: mockPresenter)
        sut.loadViewIfNeeded()
        
        // Assert

        XCTAssertNotNil(sut.labelResult, "Failed - Presenter not created with MillionaireViewController.")
        XCTAssertNotNil(sut.imageView, "Failed - Presenter not created with MillionaireViewController.")
        XCTAssertNotNil(sut.labelCheer, "Failed - Presenter not created with MillionaireViewController.")

    }
    
    func testMillionaireView_WhenIsMillionaire_ShouldShowYES() {
        
        // Arrange

        let expectedText = "yes"
        let mockPresenter = MockMillionairePresenter()
        let sut = MillionaireViewController(withPresenter: mockPresenter)
        sut.loadViewIfNeeded()
        
        // Act

        sut.isBitcoinMillionaire.send(true)
        
        // Assert

        guard let text = sut.labelResult.text?.lowercased() else {
            XCTFail("Failed - View is missing the expected UILabel")
            return
        }
        
        XCTAssertTrue(text.contains(expectedText), "Failed - Presenter not created with MillionaireViewController.")

    }
    
    func testMillionaireView_WhenIsNotMillionaire_ShouldShowNO() {
        
        // Arrange

        let expectedText = "no"
        let mockPresenter = MockMillionairePresenter()
        let sut = MillionaireViewController(withPresenter: mockPresenter)
        sut.loadViewIfNeeded()
        
        // Act

        sut.isBitcoinMillionaire.send(false)
        
        // Assert

        guard let text = sut.labelResult.text?.lowercased() else {
            XCTFail("Failed - View is missing the expected UILabel")
            return
        }
        
        XCTAssertTrue(text.contains(expectedText), "Failed - Presenter not created with MillionaireViewController.")

    }
    
    func testMillionaireView_WhenLoaded_CallsCheckMillionaireOnPresenter() {
        
        // Arrange

        let mockPresenter = MockMillionairePresenter()
        
        // Act
        
        let sut = MillionaireViewController(withPresenter: mockPresenter)
        sut.loadViewIfNeeded()
        
        // Assert

        XCTAssertTrue(mockPresenter.isCalledCheckIfUserIsBitcoinMillionaire, "Failed - Presenter not called for CheckIfUserIsBitcoinMillionaire")

    }
    
    func testMillionaireView_WhenDropped_ShouldNotCauseRetainCycle() {
        
        // Arrange

        weak var weakReferenceToPresenter: MillionairePresenter? = nil
        
        // Act
        
        var sut: MillionaireViewController? = MillionaireViewController()
        weakReferenceToPresenter = sut?.millionairePresenter as? MillionairePresenter
        
        sut = nil
        
        // Assert

        XCTAssertNil(weakReferenceToPresenter, "Failed - Presenter not deallocated when Module dropped.")

    }

}
