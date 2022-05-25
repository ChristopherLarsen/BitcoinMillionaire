//
//  MockBitcoinUserDefaults.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-19.
//

import Foundation
import UIKit
@testable import BitcoinMillionaire


// MARK: - MockBitcoinUserDefaults

class MockBitcoinUserDefaults : BitcoinUserDefaults {
        
    var tempDictionary: Dictionary<String, Any> = [:]
    var dictionary: Dictionary<String, Any> = [:]
    
    override func object(forKey defaultName: String) -> Any? {
        return tempDictionary[defaultName]
    }
    
    override func set(_ value: Any?, forKey defaultName: String) {
        if let object = value as? AnyObject {
            tempDictionary[defaultName] = object
        } else {
            fatalError("Cannot mock non-object entities.")
        }
    }
    
    override func removeObject(forKey defaultName: String) {
        tempDictionary.removeValue(forKey: defaultName)
    }
    
    override func synchronize() {
        dictionary = tempDictionary
        tempDictionary = dictionary
    }

}

// MARK: - Test Helper Methods

extension MockBitcoinUserDefaults {
    
    func clearUserDefaults() {
        tempDictionary = [:]
        synchronize()
    }
    
}
