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

    if let bitcoinAction = action as? BitcoinAction {
        state = bitcoinReducer(bitcoinAction: bitcoinAction, state: state)
        state = messageReducer(messageAction: MessageAction.updateMessage, state: state)
    }

    if let messageAction = action as? MessageAction {
        state = messageReducer(messageAction: messageAction, state: state)
    }

    return state
}

