//
//  BitcoinPriceRepository.swift
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
    
    init(webService: WebServiceProtocol = WebService()) {
        self.webService = webService
    }
    
    func getLatest() -> AnyPublisher<BitcoinPrice,Error> { 
        return webService.get(endpoint: Endpoint.getLatestBitcoinPrice, responseType: APIResponse.self)
            .map({ $0.bpi.bitcoinPrice }) 
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
