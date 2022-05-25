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
    
    func addBitcoin(amountToAdd: Float) -> Result<Bool, UserBitcoinServiceError>
}


// MARK: - UserBitcoinServiceError

enum UserBitcoinServiceError: Error {
    case insufficientBitcoinToRemove
    case unknownError
}

// MARK: - UserBitcoinService

class UserBitcoinService: UserBitcoinServiceProtocol {
    
    /// The current number of Bitcoins the User has.
    /// Subscribe to this Publisher to repond to changes in the current amount of Bitcoins the user has.
    ///
    var currentUserBitcoins = CurrentValueSubject<UserBitcoinEntity, Error>( UserBitcoinEntity(initialCoins: 2.0) )
    
    private let database: DatabaseRepositoryProtocol
    
    init(database: DatabaseRepositoryProtocol = DatabaseService() ) {
        
        self.database = database
        fetchLatestUserBitcoinsFromDatabase()
    }
    
    // MARK: - Public
    
    func addBitcoin(amountToAdd: Float) -> Result<Bool, UserBitcoinServiceError> {
        
        let currentBitcoins: Float = currentUserBitcoins.value.bitcoins
        
        let newValue = currentBitcoins + amountToAdd
        
        let userBitcoinEntity = UserBitcoinEntity(initialCoins: newValue)
        
        currentUserBitcoins.value = userBitcoinEntity
        
        saveCurrentBitcoinsToDatabase()
        
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
        
        saveCurrentBitcoinsToDatabase()
        
        return .success(true)
    }
    
}

// MARK: - Private
extension UserBitcoinService {
    
    func fetchLatestUserBitcoinsFromDatabase() {
        
        if case .success(let readObject) = database.read(key: Key.keyUserBitcoin) {
            if let initialCoins = readObject as? Float {
                self.currentUserBitcoins.value = UserBitcoinEntity(initialCoins: initialCoins)
            }
        } else {
            
            initializeUserBitcoinsWithZeroBitcoins()
            
            if case .success(let readObject) = database.read(key: Key.keyUserBitcoin) {
                
                guard let initialCoins = readObject as? Float else {
                    print("Error - Failed to initialize the UserBitcoinEntity")
                    return
                }
                
                
                self.currentUserBitcoins.value = UserBitcoinEntity(initialCoins: initialCoins)
            }
        }
        
    }
    
    func initializeUserBitcoinsWithZeroBitcoins() {
        
        print("Initializing the Database with a zero bitcoin UserBitcoinEntity")
        
        let initialCoins: Float = 0.0
        
        let result = database.create(key: Key.keyUserBitcoin, object: initialCoins)
        
        guard case .success(_) = result else {
            print("The database operation was not successful.")
            return
        }
        
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
