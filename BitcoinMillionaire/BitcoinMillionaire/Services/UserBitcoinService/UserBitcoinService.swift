//
//  UserBitcoinService.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-19.
//

import Foundation
import UIKit
import Combine


// MARK: - UserBitcoinServiceProtocol

protocol UserBitcoinServiceProtocol {
    var currentUserBitcoins: CurrentValueSubject<UserBitcoinEntity, Error> { get }
}


// MARK: - UserBitcoinServiceError

enum UserBitcoinServiceError: Error {
    case insufficientBitcoinToRemove
    case unknownError
}

// MARK: - UserBitcoinService

class UserBitcoinService: UserBitcoinServiceProtocol {
    
    /// The curreny number of Bitcoins the User has.
    /// Subscribe to this Publisher to repond to changes in the current amount of Bitcoins the user has.
    ///
    var currentUserBitcoins = CurrentValueSubject<UserBitcoinEntity, Error>( UserBitcoinEntity(initialCoins: 0.0) )
    
    private let database: DatabaseServiceProtocol
    
    init(database: DatabaseServiceProtocol) {
        
        self.database = database
        fetchLatestUserBitcoinsFromDatabase()
    }
    
    // MARK: - Published
    
    func fetchLatestUserBitcoinsFromDatabase() {
        
        print("Fetching ...")
        
        if case .success(let readObject) = database.read(key: Constants.keyUserBitcoin) {
            print("Hit")
            if let userBitcoinEntity = readObject as? UserBitcoinEntity {
                self.currentUserBitcoins.value = userBitcoinEntity
            }
        } else {
            print("Miss")
            // TODO: Handle a miss on the Database
        }
        
    }
    
    func addBitcoin(amountToAdd: Float) -> Result<Bool, UserBitcoinServiceError> {
        
        let currentBitcoins: Float = currentUserBitcoins.value.bitcoins
        
        let newValue = currentBitcoins + amountToAdd
        
        let userBitcoinEntity = UserBitcoinEntity(initialCoins: newValue)
        
        currentUserBitcoins.value = userBitcoinEntity
        
        return .success(true)
    }

    func removeBitcoin(amountToRemove: Float) -> Result<Bool, UserBitcoinServiceError> {

        let currentBitcoins: Float = currentUserBitcoins.value.bitcoins
        
        guard currentBitcoins > amountToRemove else {
            return .failure(.insufficientBitcoinToRemove)
        }
        
        let newValue = currentBitcoins - amountToRemove
        
        let userBitcoinEntity = UserBitcoinEntity(initialCoins: newValue)
        
        currentUserBitcoins.value = userBitcoinEntity
        
        return .success(true)
    }

    func saveCurrentBitcoinsToDatabase() {
        // TODO:
    }
    
}

