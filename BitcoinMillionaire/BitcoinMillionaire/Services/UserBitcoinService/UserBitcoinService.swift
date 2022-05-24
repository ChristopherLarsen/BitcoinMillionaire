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
    
    private let database: DatabaseRepositoryProtocol
    
    init(database: DatabaseRepositoryProtocol) {
        
        self.database = database
        fetchLatestUserBitcoinsFromDatabase()
    }
    
    // MARK: - Public
    
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
    
}

// MARK: - Private

private extension UserBitcoinService {
    
    func fetchLatestUserBitcoinsFromDatabase() {
        
        if case .success(let readObject) = database.read(key: Key.keyUserBitcoin) {
            if let userBitcoinEntity = readObject as? UserBitcoinEntity {
                self.currentUserBitcoins.value = userBitcoinEntity
            }
        } else {
            
            initializeUserBitcoinsWithZeroBitcoins()
            
            if case .success(let readObject) = database.read(key: Key.keyUserBitcoin) {
                
                guard let userBitcoinEntity = readObject as? UserBitcoinEntity else {
                    print("Error - Failed to initialize the UserBitcoinEntity")
                    return
                }
                
                
                self.currentUserBitcoins.value = userBitcoinEntity
            }
        }
        
    }
    
    func initializeUserBitcoinsWithZeroBitcoins() {
        
        print("Initializing the Database with a zero bitcoin UserBitcoinEntity")
        
        let initialCoins: Float = 0.0
        
        database.create(key: Key.keyUserBitcoin, object: initialCoins)
    }
    
    func saveCurrentBitcoinsToDatabase() {
        
        let bitcoins: Float = currentUserBitcoins.value.bitcoins
        
        let resultDatabaseOperation = database.update(key: Key.keyUserBitcoin, object: bitcoins)
        
        switch resultDatabaseOperation {
        case .success(let result):
            print("Database - Saved user bitcoin to Database. \(result)")
        case .failure(let databaseError):
            print("Database Error - Failed to save user bitcoin to Database. \(databaseError)")
        }
        
    }
}
