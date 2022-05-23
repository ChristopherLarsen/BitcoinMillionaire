//
//  HomeInteractorProtocol.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 19/05/22.
//

import Foundation
import Combine

protocol HomeInteractorProtocol: AnyObject {
    func checkLatestBitcoinPrice() -> AnyPublisher<BitcoinPrice,Error>
    func checkBitcoinAvailability() -> CurrentValueSubject<UserBitcoinEntity, Error>
    func checkIfIAmAMillionaire()
}

