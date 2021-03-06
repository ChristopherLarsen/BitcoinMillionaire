//
//  MockDatabase.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-19.
//

import Foundation
@testable import BitcoinMillionaire


class MockDatabase : DatabaseService {
    
    override func create(key: String, object: Any) -> Result<Bool, DatabaseError> {
        print("MockDatabase - Create")
        return super.create(key: key, object: object)
    }
    
    override func read(key: String) -> Result<Any, DatabaseError> {
        print("MockDatabase - Read")
        return super.read(key: key)
    }
    
    override func update(key: String, object: Any) -> Result<Bool, DatabaseError> {
        print("MockDatabase - Update")
        return super.update(key: key, object: object)
    }
    
    override func delete(key: String) -> Result<Bool, DatabaseError> {
        print("MockDatabase - Delete")
        return super.delete(key: key)
    }
    
}
