//
//  BPI.swift
//  BitcoinMillionaire
//
//  Created by Jorge Mattei on 5/19/22.
//

import Foundation

struct BPI : Decodable {
    
    var bitcoinPrice : BitcoinPrice
    
    enum CodingKeys : String, CodingKey {
        case bitcoinPrice = "USD"
    }
}
