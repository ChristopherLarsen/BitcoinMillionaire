//
//  Actions.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-06-01.
//

import Foundation
import ReSwift


enum BitcoinAction : Action {
    
    case addBitcoin(amount: Double)
    case removeBitcoin(amount: Double)
    
}

enum MessageAction : Action {
    
    case updateMessage
    
}
