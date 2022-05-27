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
 
protocol UserBitcoinServiceProtocol : AnyObject {
    var currentUserBitcoins: CurrentValueSubject<UserBitcoinEntity, Never> { get }
    func addBitcoin(amountToAdd: Double) -> Result<Bool, Error>
    func removeBitcoin(amountToRemove: Double) -> Result<Bool, Error>
    func fetchLatestUserBitcoinsFromDatabase() 
}

// MARK: - UserBitcoinServiceError

enum UserBitcoinServiceError: Error {
    case insufficientBitcoinToRemove
    case cannotAddZeroOrNegativeAmount
    case unknownError
    
    var localizedDescription : String? {
        switch self {
        case .insufficientBitcoinToRemove:
            return "Insufficient Bitcoin To Remove"
        case .cannotAddZeroOrNegativeAmount:
            return "Cannot Add Zero or Negative Amount"
        case .unknownError:
            return "unknownError"
        }
    }
}

// MARK: - UserBitcoinService

class UserBitcoinService: UserBitcoinServiceProtocol {
    
    /// The current number of Bitcoins the User has.
    /// Subscribe to this Publisher to repond to changes in the current amount of Bitcoins the user has.
    ///
    var currentUserBitcoins = CurrentValueSubject<UserBitcoinEntity, Never>( UserBitcoinEntity(initialCoins: 0.0) )
    
    private let database: DatabaseRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    /// broadcastToOtherUserBitcoinServices
    ///
    /// Prevents a change feedback loop from occuring when the bitcoin is updated.
    /// When enabled, all other Services are notified of the change so they can update with the latest
    /// value stored in the Database.
    ///
    private var broadcastToOtherUserBitcoinServices = false
    
    init(database: DatabaseRepositoryProtocol = DatabaseService() ) {
        
        self.database = database
                
        fetchLatestUserBitcoinsFromDatabase()

        subscribeToChangesToCurrentUserBitcoin()
        subscribeToNotificationsOfChangesToCurrentUserBitcoin()

        broadcastToOtherUserBitcoinServices = true
    }
    
    // MARK: - Public
    
    func addBitcoin(amountToAdd: Double) -> Result<Bool, Error> {
        
        guard amountToAdd > 0.0 else  {
            return .failure(UserBitcoinServiceError.cannotAddZeroOrNegativeAmount)
        }
        
        let currentBitcoins: Double = currentUserBitcoins.value.bitcoins
        
        let newValue = currentBitcoins + amountToAdd
        
        let userBitcoinEntity = UserBitcoinEntity(initialCoins: newValue)
        
        currentUserBitcoins.value = userBitcoinEntity
                
        return .success(true)
    }
    
    func removeBitcoin(amountToRemove: Double) -> Result<Bool, Error> {
        guard amountToRemove > 0.0 else  {
            return .failure(UserBitcoinServiceError.cannotAddZeroOrNegativeAmount)
        }
        
        let currentBitcoins: Double = currentUserBitcoins.value.bitcoins
        
        guard currentBitcoins > amountToRemove else {
            return .failure(UserBitcoinServiceError.insufficientBitcoinToRemove)
        }
        
        let newValue = currentBitcoins - amountToRemove
        
        let userBitcoinEntity = UserBitcoinEntity(initialCoins: newValue)
        
        currentUserBitcoins.value = userBitcoinEntity
        
        return .success(true)
    }

    // MARK: - deinit
    
    deinit {
        print("deinit UserBitcoinService")
    }
    
}

// MARK: - Private

extension UserBitcoinService {
    
    func fetchLatestUserBitcoinsFromDatabase() {
        
        if case .success(let readObject) = database.read(key: Key.keyUserBitcoin) {
            
            if let initialCoins = readObject as? Double {
                
                if initialCoins != self.currentUserBitcoins.value.bitcoins {
                    self.currentUserBitcoins.value = UserBitcoinEntity(initialCoins: initialCoins)
                }
                
            }
            
        } else {
            
            initializeUserBitcoinsWithZeroBitcoins()
            
            if case .success(let readObject) = database.read(key: Key.keyUserBitcoin) {
                
                guard let initialCoins = readObject as? Double else {
                    print("Error - Failed to initialize the UserBitcoinEntity")
                    return
                }
                
                
                self.currentUserBitcoins.value = UserBitcoinEntity(initialCoins: initialCoins)
            }
        }
        
    }
    
    func subscribeToChangesToCurrentUserBitcoin() {
        
        currentUserBitcoins.sink { [weak self] userBitcoinEntity in
            
            guard let self = self else {
                return
            }

            self.saveCurrentBitcoinsToDatabase()
            self.postNotificationWhenUserBitcoinChanges()
            
        }.store(in: &cancellables)
        
    }
    
    func subscribeToNotificationsOfChangesToCurrentUserBitcoin() {
        
        NotificationCenter.default.publisher(for: .userBitcoinChanged).sink { complete in
            // Complete
        } receiveValue: { [weak self] notification in
            
            guard let self = self else {
                return
            }
            
            guard let postingUserBitcoinService = notification.object as? UserBitcoinService else {
                return
            }
            
            guard postingUserBitcoinService !== self else {
                // Ignore Notifications that were posted by the posting UserBitcoinService.
                return
            }

            print("Received Notification: userBitcoinChanged. Updating UserBitcoins from the Database")
            
            // When notified of changes from another UserBitcoinService
            // we disable broadcasting changes to the bitcoin value while we update
            // to the latest value stored in the database.
            //
            self.broadcastToOtherUserBitcoinServices = false
            self.fetchLatestUserBitcoinsFromDatabase()
            self.broadcastToOtherUserBitcoinServices = true
            
        }.store(in: &cancellables)
        
    }
        
    func postNotificationWhenUserBitcoinChanges() {
        
        guard broadcastToOtherUserBitcoinServices else {
            return
        }
        
        print("Notification: UserBitcoins changed: \(currentUserBitcoins.value.bitcoins)")
        NotificationCenter.default.post(name: .userBitcoinChanged, object: self)
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
        
        guard broadcastToOtherUserBitcoinServices else {
            return
        }

        let bitcoins: Double = currentUserBitcoins.value.bitcoins
        
        let resultDatabaseOperation = database.update(key: Key.keyUserBitcoin, object: bitcoins)
        
        switch resultDatabaseOperation {
        case .success(let result):
            print("Database - Saved \(bitcoins) user bitcoin to Database: \(result).")
        case .failure(let databaseError):
            print("Database Error - Failed to save user bitcoin to Database: \(databaseError).")
        }
        
    }
     
}
