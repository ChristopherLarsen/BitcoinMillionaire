//
//  DatabaseService.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-19.
//

import Foundation


// MARK: - DatabaseRepositoryProtocol

protocol DatabaseRepositoryProtocol {
    
    init(userDefaults: UserDefaultsProtocol)
    
    func create(key: String, object: Any) -> Result<Bool, DatabaseError>
    func read(key: String) -> Result<Any, DatabaseError>
    func update(key: String, object: Any) -> Result<Bool, DatabaseError>
    func delete(key: String) -> Result<Bool, DatabaseError>
    
}


// MARK: - DatabaseService

class DatabaseService: DatabaseRepositoryProtocol {
    
    private let userDefaults: UserDefaultsProtocol

    // MARK: - Init
    
    required init(userDefaults: UserDefaultsProtocol) {
        self.userDefaults = userDefaults
    }
    
    // MARK: - CRUD Repository Functions
    
    func create(key: String, object: Any) -> Result<Bool, DatabaseError> {
        print("saving \(object) to \(key)")
        userDefaults.set(object, forKey: key)
        userDefaults.synchronize()
        
        return .success(true)
    }
    
    func read(key: String) -> Result<Any, DatabaseError> {
        
        if let object = userDefaults.object(forKey: key) {
            return .success(object)
        }
        return .failure(.objectDoesNotExist)
    }
    
    func update(key: String, object: Any) -> Result<Bool, DatabaseError> {

        guard userDefaults.object(forKey: key) != nil else {
            return .failure(.objectDoesNotExist)
        }
        
        userDefaults.set(object, forKey: key)
        userDefaults.synchronize()

        return .success(true)
    }
    
    func delete(key: String) -> Result<Bool, DatabaseError> {
        
        if userDefaults.object(forKey: key) == nil {
            return .failure(.objectDoesNotExist)
        }
        
        userDefaults.removeObject(forKey: key)
        userDefaults.synchronize()

        if userDefaults.object(forKey: key) != nil {
            return .failure(.failedToDeleteObject)
        }
        
        return .success(true)
    }
    
}

