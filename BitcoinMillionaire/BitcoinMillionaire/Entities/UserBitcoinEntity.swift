//
//  UserBitcoinEntity.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-19.
//

import Foundation


// MARK: - UserBitcoinEntityProtocol

protocol UserBitcoinEntityProtocol {
    var bitcoins: Double { get }
    init(initialCoins: Double)
}


// MARK: - UserBitcoinEntity

class UserBitcoinEntity: UserBitcoinEntityProtocol {

    /// Private members

    private let _bitcoins: Double
    
    /// Public
    
    var bitcoins: Double {
        get {
            return _bitcoins
        }
    }
    
    /// Designated Initializer
    
    required init(initialCoins: Double) {
        
        if initialCoins < 0.0 {
            print("ERROR: You cannot have less than zero Bitcoins.")
        }
        
        self._bitcoins = max(0.0, initialCoins)
    }
    
}

