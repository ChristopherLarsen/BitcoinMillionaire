//
//  AppReducer.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 25/05/22.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: State?) -> State {
    if let action = action as? BitcoinAction {
        var state = state ?? State(message: "You need \(35.00 - action.bitcoins) bitcoins to become a Millionaire")
        state.message = "You need \(35.00 - action.bitcoins) bitcoins to become a Millionaire"
        return state
    }
    return State(message: "You need \(35.00) bitcoins to become a Millionaire")
}
