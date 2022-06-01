//
//  Reducers.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-06-01.
//

import Foundation
import ReSwift


func reducer(action: Action, state: State?) -> State {

    var state: State = state ?? State()
    
    if let messageAction = action as? MessageAction {
        state = messageReducer(messageAction: messageAction, state: state)
    }

    if let bitcoinAction = action as? BitcoinAction {
        state = bitcoinReducer(bitcoinAction: bitcoinAction, state: state)
    }

    return state
}

