//
//  UserBitcoinEntity.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-19.
//

import Foundation


// MARK: - UserBitcoinEntityProtocol

protocol UserBitcoinEntityProtocol {
    var bitcoins: Float { get }
    init(initialCoins: Float)
}


// MARK: - UserBitcoinEntity

class UserBitcoinEntity: UserBitcoinEntityProtocol {

    /// Private members

    private let _bitcoins: Float
    
    /// Public
    
    var bitcoins: Float {
        get {
            return _bitcoins
        }
    }
    
    /// Designated Initializer
    
    required init(initialCoins: Float) {
        
        if initialCoins < 0.0 {
            print("ERROR: You cannot have less than zero Bitcoins.")
        }
        
        self._bitcoins = max(0.0, initialCoins)
    }
    
}

