//
//  Double+Extensions.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-06-01.
//

import Foundation

extension Double {
    
    var roundedToEightDigits: Double {
        let eightPlaces: Double = 100_000_000.0
        let tempDouble: Double = self * eightPlaces
        let roundedDouble: Double = tempDouble.rounded()
        return roundedDouble / eightPlaces
    }
    
}
