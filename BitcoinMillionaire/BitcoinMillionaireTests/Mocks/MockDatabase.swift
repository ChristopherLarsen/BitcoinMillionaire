//
//  MockDatabase.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-19.
//

import Foundation
@testable import BitcoinMillionaire


class MockDatabase : DatabaseServiceProtocol {
    
    let userDefaults: UserDefaultsProtocol
    
    required init(userDefaults: UserDefaultsProtocol) {
        self.userDefaults = userDefaults
    }
    
    func create(key: String, object: Codable) -> Result<Bool, DatabaseError> {
        // TODO:
        return .failure(.unknown)
    }
    
    func read(key: String) -> Result<Codable, DatabaseError> {
        // TODO:
        return .failure(.unknown)
    }
    
    func update(key: String, object: Codable) -> Result<Bool, DatabaseError> {
        // TODO:
        return .failure(.unknown)
    }
    
    func delete(key: String) -> Result<Bool, DatabaseError> {
        // TODO:
        return .failure(.unknown)
    }
    
}
