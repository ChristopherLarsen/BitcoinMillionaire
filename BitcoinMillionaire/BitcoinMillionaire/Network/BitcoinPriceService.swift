//
//  BitcoinPriceService.swift
//  BitcoinMillionaire
//
//  Created by Jorge Mattei on 5/19/22.
//

import Foundation
import Combine

protocol BitcoinPriceServiceProtocol {
    func getLatest() -> AnyPublisher<BitcoinPrice,Error>
    func getLatestFromDataBase() -> AnyPublisher<Double,Error>
}

class BitcoinPriceService : BitcoinPriceServiceProtocol {
    
    let webService : WebServiceProtocol
    let databaseService : DatabaseRepositoryProtocol
    
    init(webService: WebServiceProtocol = WebService(), databaseService: DatabaseRepositoryProtocol = DatabaseService()) {
        self.webService = webService
        self.databaseService = databaseService
    }
    
    func getLatest() -> AnyPublisher<BitcoinPrice,Error> { 
        return webService.get(endpoint: Endpoint.getLatestBitcoinPrice, responseType: APIResponse.self)
            .map({ $0.bpi.bitcoinPrice })
            .handleEvents(receiveOutput: { bitcoinPriceObject in
                // NOTE: The bitcoin price service should save the value to the database directly.
                print("Saving \(bitcoinPriceObject.rateFloat) in database")
                let _ = self.databaseService.create(key: Key.keyBitcoinPrice, object: Double(bitcoinPriceObject.rateFloat))
            })
            .eraseToAnyPublisher() 
    }
    
    func getLatestFromDataBase() -> AnyPublisher<Double,Error> {
        return BitcoinUserDefaults().defaults
            .publisher(for: \.keyBitcoinPrice)
            .handleEvents(receiveOutput: { bitcoinPrice in
                print("Price in Database: \(bitcoinPrice)")
            }).setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
}
