//
//  HomeInteractor.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation
import Combine

class HomeInteractor: HomeInteractorProtocol {
   
    //MARK: Variables & Constants
    var bitCoinPriceRepository: BitcoinPriceService!
    var userBitcoinService: UserBitcoinServiceProtocol!
    private var subscription: AnyCancellable?

    //MARK: Lifecycle methods
    init(with repository: BitcoinPriceService, userBitcoinService: UserBitcoinServiceProtocol = UserBitcoinService(database: DatabaseService(userDefaults: BitcoinUserDefaults()))) {
        self.bitCoinPriceRepository = repository
        self.userBitcoinService = userBitcoinService
    }
    
    //MARK: Custom methods
    
    /// Method to call bitcoin repository to read latest price of bitcoin.
    /// - Returns: A Publisher containing Bitcoin Price entity or Error, if any.
    func checkLatestBitcoinPrice() -> AnyPublisher<BitcoinPrice,Error> {
        print("Checking latest Bitcoin Price")
        return bitCoinPriceRepository.getLatest()
    }
    
    /// Method to call bitcoin user bitcoin service to fetch available number of bitcoins with the user.
    /// - Returns: A Subject publishing UserBitcoinEntity or Error, if any
    func checkBitcoinAvailability() -> CurrentValueSubject<UserBitcoinEntity, Error> {
        return userBitcoinService.currentUserBitcoins
    }
    
    /// Method to check if the user is millionaire
    func checkIfIAmAMillionaire() {
        print("Check If I am a Millionaire")
    }
}
