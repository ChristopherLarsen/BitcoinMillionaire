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
        
        if case .success(let readObject) = database.read(key: Constants.keyUserBitcoin) {
            if let userBitcoinEntity = readObject as? UserBitcoinEntity {
                self.currentUserBitcoins.value = userBitcoinEntity
            }
        }
        
    }
    
}

