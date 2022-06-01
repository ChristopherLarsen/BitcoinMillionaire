//
//  MessageReducer.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-06-01.
//

import Foundation
import ReSwift


func messageReducer(messageAction: MessageAction, state: State) -> State {

    var state: State = state
    
    let bitcoins: Double = state.bitcoinState.bitcoin
    let bitcoinPrice: Double = state.priceState.price
    
    let balance = (Double(Constants.oneMillionDollars)/bitcoinPrice) - bitcoins
    let roundedOffBalance = Double(round(100000000 * balance) / 100000000)
    let isMillionaire = roundedOffBalance <= 0
    
    state.message = isMillionaire ? "You are a Millionaire!" : "You need \(roundedOffBalance) bitcoins to become a Millionaire!"

    return state
}
