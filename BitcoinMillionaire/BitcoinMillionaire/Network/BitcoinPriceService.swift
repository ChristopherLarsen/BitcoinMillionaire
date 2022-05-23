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
    
}
