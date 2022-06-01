//
//  BitcoinState.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-06-01.
//

import Foundation
import ReSwift


struct BitcoinState {
    
    var bitcoin: Double
    
    /// The Bitcoin amount is initialized from the Database by default.
    /// Providing an initial value overrides the stored value.
    ///
    init(bitcoin: Double? = nil, databaseService: DatabaseService = DatabaseService() ) {
        
        if let bitcoin = bitcoin {
            self.bitcoin = bitcoin
            return
        }
        
        let databaseService = DatabaseService()
        let result = databaseService.read(key: Key.keyBitcoin)
        
        switch result {
        case .success(let value):
            if let valueAsDouble: Double = value as? Double {
                self.bitcoin = valueAsDouble
            } else {
                let initialBitcoin: Double = 0.0
                _ = databaseService.update(key: Key.keyBitcoin, object: initialBitcoin)
                self.bitcoin = initialBitcoin
            }
        case .failure(let databaseError):
            print("Error reading from Database: \(databaseError)")
            let initialBitcoin: Double = 0.0
            _ = databaseService.create(key: Key.keyBitcoin, object: initialBitcoin)
            self.bitcoin = 0.0
        }
        
    }
    
}
