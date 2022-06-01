//
//  PriceState.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-06-01.
//

import Foundation
import ReSwift


struct PriceState {
    
    var price: Double
    
    init(price: Double? = nil, databaseService: DatabaseService = DatabaseService() ) {
        
        if let price = price {
            self.price = price
            return
        }
        
        let databaseService = DatabaseService()
        let result = databaseService.read(key: Key.keyBitcoinPrice)
        
        switch result {
        case .success(let value):
            if let valueAsDouble: Double = value as? Double {
                self.price = valueAsDouble
            } else {
                let initialPrice: Double = 0.0
                _ = databaseService.update(key: Key.keyBitcoinPrice, object: initialPrice)
                self.price = initialPrice
            }
        case .failure(let databaseError):
            print("Error reading from Database: \(databaseError)")
            let initialPrice: Double = 0.0
            _ = databaseService.create(key: Key.keyBitcoinPrice, object: initialPrice)
            self.price = initialPrice
        }
        
    }
    
}

