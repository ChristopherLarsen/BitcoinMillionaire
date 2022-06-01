//
//  UserBitcoinService.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-19.
//

import Foundation
import UIKit
import ReSwift
import Combine


// MARK: - UserBitcoinServiceProtocol
 
protocol UserBitcoinServiceProtocol : AnyObject {
    func addBitcoin(amountToAdd: Double) -> Result<Bool, Error>
    func removeBitcoin(amountToRemove: Double) -> Result<Bool, Error>
}

// MARK: - UserBitcoinServiceError

enum UserBitcoinServiceError: Error {
    
    case insufficientBitcoinToRemove
    case cannotAddZeroOrNegativeAmount
    case cannotRemoveZeroOrNegativeAmount
    case unknownError
    
    var localizedDescription : String? {
        switch self {
        case .insufficientBitcoinToRemove:
            return "Insufficient Bitcoin To Remove"
        case .cannotAddZeroOrNegativeAmount:
            return "Cannot Add Zero or Negative Amount"
        case .cannotRemoveZeroOrNegativeAmount:
            return "Cannot Remove Zero or Negative Amount"
        case .unknownError:
            return "unknownError"
        }
    }
}

// MARK: - UserBitcoinService

class UserBitcoinService: UserBitcoinServiceProtocol {

    let store: Store<State>
    
    // MARK: init
    
    init(store: Store<State> = mainStore) {
        self.store = store
    }
    
    // MARK: - Public
    
    func addBitcoin(amountToAdd: Double) -> Result<Bool, Error> {
        
        let amountToAdd = amountToAdd.roundedToEightDigits
        
        guard amountToAdd > 0.0 else  {
            return .failure(UserBitcoinServiceError.cannotAddZeroOrNegativeAmount)
        }

        store.dispatch(BitcoinAction.addBitcoin(amount: amountToAdd))
                
        return .success(true)
    }
    
    func removeBitcoin(amountToRemove: Double) -> Result<Bool, Error> {
        
        let amountToRemove = amountToRemove.roundedToEightDigits
        
        guard amountToRemove > 0.0 else  {
            return .failure(UserBitcoinServiceError.cannotRemoveZeroOrNegativeAmount)
        }
        
        guard amountToRemove <= store.state.bitcoinState.bitcoin else {
            return .failure(UserBitcoinServiceError.insufficientBitcoinToRemove)
        }

        store.dispatch(BitcoinAction.removeBitcoin(amount: amountToRemove))
                
        return .success(true)
    }

    // MARK: - deinit
    
    deinit {
        print("deinit UserBitcoinService")
    }
    
}
