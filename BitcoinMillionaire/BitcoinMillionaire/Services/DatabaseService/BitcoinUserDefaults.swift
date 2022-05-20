//
//  UserDefaults.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 19/05/22.
//

import UIKit

class BitcoinUserDefaults: UserDefaultsProtocol {
    let defaults = UserDefaults.standard
    
    func object(forKey defaultName: String) -> Any? {
        defaults.object(forKey: defaultName)
    }
    
    func set(_ value: Any?, forKey defaultName: String) {
        defaults.set(value, forKey: defaultName)
        synchronize()
    }
    
    func removeObject(forKey defaultName: String) {
        defaults.removeObject(forKey: defaultName)
        synchronize()
    }
    
    func synchronize() {
        defaults.synchronize()
    }
    
    
}
