//
//  DatabaseService.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-19.
//

import Foundation


// MARK: - DatabaseRepositoryProtocol

protocol DatabaseRepositoryProtocol {
        
    func create(key: String, object: Any) -> Result<Bool, DatabaseError>
    func read(key: String) -> Result<Any, DatabaseError>
    func update(key: String, object: Any) -> Result<Bool, DatabaseError>
    func delete(key: String) -> Result<Bool, DatabaseError>
    
}


// MARK: - DatabaseService

class DatabaseService: DatabaseRepositoryProtocol {
    
    private let userBitcoinDefaults: BitcoinUserDefaults

    // MARK: - Init
    
    required init(userDefaults: BitcoinUserDefaults = BitcoinUserDefaults() ) {
        self.userBitcoinDefaults = userDefaults
    }
    
    // MARK: - CRUD Repository Functions
    
    func create(key: String, object: Any) -> Result<Bool, DatabaseError> {

        userBitcoinDefaults.set(object, forKey: key)
        userBitcoinDefaults.synchronize()
        
        return .success(true)
    }
    
    func read(key: String) -> Result<Any, DatabaseError> {
        
        if let object = userBitcoinDefaults.object(forKey: key) {
            return .success(object)
        }
        return .failure(.objectDoesNotExist)
    }
    
    func update(key: String, object: Any) -> Result<Bool, DatabaseError> {

        guard userBitcoinDefaults.object(forKey: key) != nil else {
            return .failure(.objectDoesNotExist)
        }
        
        userBitcoinDefaults.set(object, forKey: key)
        userBitcoinDefaults.synchronize()

        return .success(true)
    }
    
    func delete(key: String) -> Result<Bool, DatabaseError> {
        
        if userBitcoinDefaults.object(forKey: key) == nil {
            return .failure(.objectDoesNotExist)
        }
        
        userBitcoinDefaults.removeObject(forKey: key)
        userBitcoinDefaults.synchronize()

        if userBitcoinDefaults.object(forKey: key) != nil {
            return .failure(.failedToDeleteObject)
        }
        
        return .success(true)
    }
    
}

