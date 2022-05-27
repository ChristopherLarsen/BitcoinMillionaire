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
    
    /// The current value of a Bitcoin.
    /// Subscribe to this Publisher to repond to changes in the current value of a Bitcoin.
    ///
    var currentBitcoinPrice = CurrentValueSubject<Float, Error>(0.0)

    private var cancellables: Set<AnyCancellable> = []
    
    init(webService: WebServiceProtocol = WebService(), databaseService: DatabaseRepositoryProtocol = DatabaseService()) {
        self.webService = webService
        self.databaseService = databaseService
        
        getLatestFromDataBase().sink { completion in
            switch completion {
            case .failure(let error):
                self.currentBitcoinPrice.send(completion:.failure(error))
            case .finished: break
            }
        } receiveValue: { [weak self] bitcoinPrice in
            guard let self = self else {
                return
            }
            self.currentBitcoinPrice.value = Float(bitcoinPrice)
        }.store(in: &cancellables)

    }
    
    func getLatest() -> AnyPublisher<BitcoinPrice,Error> { 
        return webService.get(endpoint: Endpoint.getLatestBitcoinPrice, responseType: APIResponse.self)
            .map({ $0.bpi.bitcoinPrice })
            .handleEvents(receiveOutput: { [weak self] bitcoinPriceObject in
                guard let self = self else {
                    return
                }
                self.currentBitcoinPrice.send(bitcoinPriceObject.rateFloat)
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
