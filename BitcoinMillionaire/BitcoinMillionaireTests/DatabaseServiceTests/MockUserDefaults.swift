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
        
    var dictionary: [String: AnyObject] = [:]
    
    func object(forKey defaultName: String) -> Any? {
        return dictionary[defaultName]
    }
    
    func set(_ value: Any?, forKey defaultName: String) {
        if let object = value as? AnyObject {
            dictionary[defaultName] = object
        } else {
            fatalError("Cannot mock non-object entities.")
        }
    }
    
    func removeObject(forKey defaultName: String) {
        dictionary.removeValue(forKey: defaultName)
    }
    
    func synchronize() {
        // TODO: Use two dictionaries, one temp state, one real.
    }

}

extension MockUserDefaults {
    
    func clearUserDefaults() {
        dictionary = [:]
    }
    
}
