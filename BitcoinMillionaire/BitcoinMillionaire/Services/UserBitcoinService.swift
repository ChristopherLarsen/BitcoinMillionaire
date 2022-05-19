//
//  UserBitcoinService.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-19.
//

import Foundation


// MARK: - UserBitcoinServiceProtocol

protocol UserBitcoinServiceProtocol {
    func userBitcoin() -> UserBitcoinEntity?
}


// MARK: - UserBitcoinService

class UserBitcoinService: UserBitcoinServiceProtocol {
    
    private weak var userBitcoinEntity: UserBitcoinEntity? = nil
    
    func userBitcoin() -> UserBitcoinEntity? {
        return nil
    }
    
}
