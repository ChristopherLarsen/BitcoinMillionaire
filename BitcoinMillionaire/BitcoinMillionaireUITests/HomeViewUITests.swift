//
//  HomeViewUITests.swift
//  HomeViewUITests
//
//  Created by Christopher Larsen on 2022-05-18.
//

import XCTest

class HomeViewUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHoemViewController_WhenViewIsLoaded_RequiredUIElementsAreCreated() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let latestPriceLabel = app.staticTexts["latestPriceLabel"]
        let bitcoinImageView = app.images["bitcoinImageView"]
        let numberOfCoinsLabel = app.staticTexts["numberOfCoinsLabel"]

        let addBitcoinButton = app.buttons["Add Bitcoin"]
        let sellBitcoinButton = app.buttons["Sell Bitcoin"]
        let checkPriceButtonButton = app.buttons["Check Latest Price"]
        let millionaireCheckButton = app.buttons["Am I a Millionaire?"]
        
        XCTAssertTrue(latestPriceLabel.exists, "Label should have been there after view load")

        XCTAssertTrue(numberOfCoinsLabel.exists, "Label should have been there after view load")
        XCTAssertTrue(bitcoinImageView.exists, "Image View should have been there after view load")
        XCTAssertTrue(addBitcoinButton.isEnabled, "Button should have been enabled after view load")
        XCTAssertTrue(sellBitcoinButton.isEnabled, "Button should have been enabled after view load")
        XCTAssertTrue(checkPriceButtonButton.isEnabled, "Button should have been enabled after view load")
        XCTAssertTrue(millionaireCheckButton.isEnabled, "Button should have been enabled after view load")
    }
}
