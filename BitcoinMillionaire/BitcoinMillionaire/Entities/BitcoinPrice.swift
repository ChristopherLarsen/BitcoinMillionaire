//
//  BitcoinPrice.swift
//  BitcoinMillionaire
//
//  Created by Jorge Mattei on 5/19/22.
//

import Foundation

struct BitcoinPrice : Decodable {
    var code : String
    var symbol : String
    var rate : String
    var description : String
    var rateFloat : Float
    
    enum CodingKeys : String, CodingKey {
        case code = "code"
        case symbol = "symbol"
        case rate = "rate"
        case description = "description"
        case rateFloat = "rate_float"
    }
}
