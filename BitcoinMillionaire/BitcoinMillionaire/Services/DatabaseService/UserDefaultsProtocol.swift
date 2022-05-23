//
//  UserDefaultsProtocol.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-19.
//

import Foundation

// MARK: - UserDefaultsProtocol

protocol UserDefaultsProtocol {
    
    func object(forKey defaultName: String) -> Any?
    func set(_ value: Any?, forKey defaultName: String)
    func removeObject(forKey defaultName: String)
    func synchronize()
    
}
