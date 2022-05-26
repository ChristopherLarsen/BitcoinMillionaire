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
        let balance = (Double(Constants.oneMillionDollars)/action.bitcoinPrice) - action.bitcoins
        var state = state ?? State(message: balance <= 0 ? "You are a Millionaire!" : "You need \(balance) bitcoins to become a Millionaire!")
        state.message = balance <= 0 ? "You are a Millionaire!" : "You need \(balance) bitcoins to become a Millionaire!"
        return state
    }
    return State(message: "")
}
