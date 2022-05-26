//
//  ExtensionTests.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-26.
//

import XCTest
@testable import BitcoinMillionaire


class ExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNotificationNamesExtension_WhenCreatedFromStrings_ShouldHaveCorrectRawValue() throws {
        XCTAssertTrue(Notification.Name.userBitcoinChanged.rawValue == "userBitcoinChanged", "Failed - Incorrect Name raw value.")
        XCTAssertTrue(Notification.Name.bitcoinPriceUpdate.rawValue == "bitcoinPriceUpdate", "Failed - Incorrect Name raw value.")
    }

    func testApplicationExtension_WhenCalled_ShouldReturnKeyWindow() {
        
        let keySceneWindow: UIWindow? = UIApplication.shared.keySceneWindow
        XCTAssertNotNil(keySceneWindow, "Failed - Extension should return the Key Window.")
    }
    
    func testNavigationExtension_WhenCalled_ShouldReturnRootNavigationController() {

        guard let rootNavigationController = UINavigationController.rootNavigationController else {
            return
        }
        
        XCTAssertNotNil(rootNavigationController, "Failed - Should return the root NavigationController.")
        
    }

}
