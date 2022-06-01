//
//  AppReducerTests.swift
//  BitcoinMillionaireTests
//
//  Created by Karan Bhasin on 25/05/22.
//

import XCTest
import ReSwift
@testable import BitcoinMillionaire

class AppReducerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
  
    // TODO: Repair with new Bitcoin State to heck Message state
    
//    func testAppReducer_WhenMoreBitCoinsAreAdded_MessageShouldGetUpdatedToShowNewCriteria() {
//
//        let store = Store<State>(reducer: appReducer, state: nil)
//
//        // Player 1 choose
//        store.dispatch(BitcoinAction(bitcoins: 20.0, bitcoinPrice: 29617.224609375))
//
//        // Check result
//        XCTAssertEqual(store.state.message, "You need 13.76413601 bitcoins to become a Millionaire!")
//    }
//
//    func testAppReducer_WhenBitCoinsAreRemoved_MessageShouldGetUpdatedToShowNewCriteria() {
//
//        let store = Store<State>(reducer: appReducer, state: nil)
//
//        // Player 1 choose
//        store.dispatch(BitcoinAction(bitcoins: 10, bitcoinPrice: 29617.224609375))
//
//        // Check result
//        XCTAssertEqual(store.state.message, "You need 23.76413601 bitcoins to become a Millionaire!")
//    }
//
//    func testAppReducer_WhenBitCoinsAreMoreThenRequired_MessageShouldGetUpdatedToShowYouAreAMillionaire() {
//
//        let store = Store<State>(reducer: appReducer, state: nil)
//
//        // Player 1 choose
//        store.dispatch(BitcoinAction(bitcoins: 100, bitcoinPrice: 29617.224609375))
//
//        // Check result
//        XCTAssertEqual(store.state.message, "You are a Millionaire!")
//    }
    
}
