//
//  Constants.swift
//  BitcoinMillionaire
//
//  Created by Jorge Mattei on 5/19/22.
//

import Foundation

struct Constants {
 
    struct WebService {
        static let bitcoinPriceEndpoint = "https://api.coindesk.com/v1/bpi/currentprice.json"
    }
    
    static let oneMillionDollars: Double = 1_000_000
    
}

struct Key {
    
    static let keyUserBitcoin: String       = "keyUserBitcoin"
    static let keyBitcoinPrice: String      = "keyBitcoinPrice"

}
