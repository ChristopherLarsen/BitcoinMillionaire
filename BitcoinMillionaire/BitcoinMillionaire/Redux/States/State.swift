//
//  State.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 25/05/22.
//

import Foundation
import ReSwift

struct State {
    
    var message: String
    
    var bitcoinState: BitcoinState
    var priceState: PriceState

    init(message: String = "",
         bitcoinState: BitcoinState = BitcoinState(),
         priceState: PriceState = PriceState() ) {
        self.message = message
        self.bitcoinState = bitcoinState
        self.priceState = priceState
    }
    
}
