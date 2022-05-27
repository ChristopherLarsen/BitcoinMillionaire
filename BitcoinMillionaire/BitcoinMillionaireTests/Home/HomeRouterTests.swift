//
//  HomeRouterTests.swift
//  BitcoinMillionaireTests
//
//  Created by Karan Bhasin on 26/05/22.
//

import XCTest
@testable import BitcoinMillionaire

class HomeRouterTests: XCTestCase {

    var sut: HomeRouterProtocol!
    var navController: UINavigationController!
    
    override func setUpWithError() throws {
        sut = HomeRouter()
        navController = UINavigationController.rootNavigationController
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testHomeRouter_WhenCalledOpenAddBitcoinView_shouldPushAddBitcpoinViewController() throws {
        sut.openAddBitcoinView()
        RunLoop.current.run(until: Date.init(timeIntervalSinceNow: 0.50))
        if let topViewController = navController.topViewController {
            XCTAssertTrue(topViewController.isKind(of: AddBitcoinViewController.self))
            navController.popViewController(animated: false)
        }
    }
    
    func testHomeRouter_WhenCalledOpenSellBitcoinView_shouldPushRemoveBitcoinViewController() throws {
        sut.openSellBitcoinView()
            RunLoop.current.run(until: Date.init(timeIntervalSinceNow: 0.50))
        if let topViewController = navController.topViewController {
            XCTAssertTrue(topViewController.isKind(of: RemoveBitcoinViewController.self))
            navController.popViewController(animated: false)
        }
    }
    
    func testHomeRouter_WhenCalledOpenMillionaireView_shouldPushMillionaireViewController() throws {
        sut.openMillionaireView()
            RunLoop.current.run(until: Date.init(timeIntervalSinceNow: 0.50))
        if let topViewController = navController.topViewController {
            XCTAssertTrue(topViewController.isKind(of: MillionaireViewController.self))
            navController.popViewController(animated: false)
        }
    }
}
