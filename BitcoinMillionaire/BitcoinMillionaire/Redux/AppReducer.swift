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
        let roundedOffBalance = Double(round(100000000 * balance) / 100000000)
        var state = state ?? State(message: roundedOffBalance <= 0 ? "You are a Millionaire!" : "You need \(roundedOffBalance) bitcoins to become a Millionaire!")
        state.message = roundedOffBalance <= 0 ? "You are a Millionaire!" : "You need \(roundedOffBalance) bitcoins to become a Millionaire!"
        return state
    }
    return State(message: "")
}
