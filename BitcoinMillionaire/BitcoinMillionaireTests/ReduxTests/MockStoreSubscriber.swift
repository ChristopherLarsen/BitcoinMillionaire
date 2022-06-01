//
//  MockStoreSubscriber.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-06-01.
//

import Foundation
import ReSwift
@testable import BitcoinMillionaire
import XCTest


class MockStoreSubscriber : StoreSubscriber {
    typealias StoreSubscriberStateType = State
    
    var state: State? = nil
    
    var isCalledNewState: Bool = false
    var isReceivedState: Bool {
        return state != nil
    }
    var expection: XCTestExpectation?
    
    func newState(state: StoreSubscriberStateType) {
        isCalledNewState = true
        self.state = state
        self.expection?.fulfill()
    }
    
}
