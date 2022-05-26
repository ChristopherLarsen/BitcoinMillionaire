//
//  HomeInteractor.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation
import Combine
import ReSwift
import SwiftUI

class HomeInteractor: HomeInteractorProtocol {
    
    //MARK: Variables & Constants
    var bitcoinPriceService: BitcoinPriceServiceProtocol!
    var userBitcoinService: UserBitcoinServiceProtocol!

    //MARK: Lifecycle methods
    init(with bitcoinPriceService: BitcoinPriceServiceProtocol = BitcoinPriceService(), userBitcoinService: UserBitcoinServiceProtocol = UserBitcoinService(database: DatabaseService(userDefaults: BitcoinUserDefaults()))) {
        self.bitcoinPriceService = bitcoinPriceService
        self.userBitcoinService = userBitcoinService
    }
    
    //MARK: Custom methods
    
    /// Method to call bitcoin repository to read latest price of bitcoin .
    /// - Returns: A Publisher containing Bitcoin Price entity or Error, if any.
    func checkLatestBitcoinPrice() -> AnyPublisher<Double,Error> {
        
        print("Checking latest BitCoin Price")
        return bitcoinPriceService.getLatest()
            .map { bitcoinPrice in
                let doublePrice = Double(bitcoinPrice.rateFloat)
                print("Price Online: \(doublePrice)")
                return doublePrice
            }.eraseToAnyPublisher()
    }
    
    /// Method to call userdefaults to read latest price of bitcoin  saved in DB.
    /// - Returns: A Publisher containing Bitcoin Price entity or Error, if any.
    func checkLatestPriceFromDataBase() -> AnyPublisher<Double,Error> {
        return bitcoinPriceService.getLatestFromDataBase()
    }
    
    /// Method to call bitcoin user bitcoin service to fetch available number of bitcoins with the user.
    /// - Returns: A Subject publishing UserBitcoinEntity or Error, if any
    func checkBitcoinAvailability() -> CurrentValueSubject<UserBitcoinEntity, Never> {
        if let userBitcoinService = userBitcoinService as? UserBitcoinService {
            userBitcoinService.fetchLatestUserBitcoinsFromDatabase()
        }
        return userBitcoinService.currentUserBitcoins
    }
}
