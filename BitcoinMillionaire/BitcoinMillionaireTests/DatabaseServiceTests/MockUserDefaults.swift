//
//  MockUserDefaults.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-19.
//

import Foundation
import UIKit
@testable import BitcoinMillionaire


// MARK: - MockUserDefaults

class MockUserDefaults: UserDefaultsProtocol {
        
    var tempDictionary: Dictionary<String, Any> = [:]
    var dictionary: Dictionary<String, Any> = [:]
    
    func object(forKey defaultName: String) -> Any? {
        return tempDictionary[defaultName]
    }
    
    func set(_ value: Any?, forKey defaultName: String) {
        if let object = value as? AnyObject {
            tempDictionary[defaultName] = object
        } else {
            fatalError("Cannot mock non-object entities.")
        }
    }
    
    func removeObject(forKey defaultName: String) {
        tempDictionary.removeValue(forKey: defaultName)
    }
    
    func synchronize() {
        dictionary = tempDictionary
        tempDictionary = dictionary
    }

}

// MARK: - Test Helper Methods

extension MockUserDefaults {
    
    func clearUserDefaults() {
        tempDictionary = [:]
        synchronize()
    }
    
}
