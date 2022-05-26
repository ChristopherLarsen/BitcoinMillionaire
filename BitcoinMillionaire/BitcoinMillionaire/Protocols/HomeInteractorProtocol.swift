//
//  HomeInteractorProtocol.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 19/05/22.
//

import Foundation
import Combine

protocol HomeInteractorProtocol: AnyObject {
    func checkLatestBitcoinPrice() -> AnyPublisher<Double,Error>
    func checkBitcoinAvailability() -> CurrentValueSubject<UserBitcoinEntity, Never>
    func checkLatestPriceFromDataBase() -> AnyPublisher<Double,Error>
}

