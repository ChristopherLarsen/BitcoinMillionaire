//
//  BitcoinReducer.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-06-01.
//

import Foundation
import ReSwift


func bitcoinReducer(bitcoinAction: BitcoinAction, state: State) -> State {
    
    var state: State = state

    switch bitcoinAction {
        
    case .addBitcoin(let amount):
        
        let currentAmount = state.bitcoinState.bitcoin
        let amountToAdd = amount
        let newAmount = currentAmount + amountToAdd
        state.bitcoinState = BitcoinState(bitcoin: newAmount)
        
    case .removeBitcoin(let amount):
        
        let currentAmount = state.bitcoinState.bitcoin
        let amountToRemove = amount
        
        guard currentAmount >= amountToRemove else {
            print("Error - Insufficient bitcoin to remove.")
            return state
        }
        
        let newAmount = currentAmount - amountToRemove
        state.bitcoinState = BitcoinState(bitcoin: newAmount)
    }
    
    return state
}

