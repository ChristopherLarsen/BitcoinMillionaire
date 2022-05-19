//
//  WebService.swift
//  BitcoinMillionaire
//
//  Created by Jorge Mattei on 5/19/22.
//

import Foundation
import Combine

class WebService {
    
    func get<T:ResponseProtocol>(endpoint : Endpoint, responseType: T.Type) -> AnyPublisher<T, Error>  {
        let url = URL(string: endpoint.urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}

extension WebService {
    enum Endpoint  {
        case getLatestBitcoinPrice
        
        var urlString : String {
            switch self {
            case .getLatestBitcoinPrice:
                return Constants.WebService.bitcoinPriceEndpoint
            }
        }
    }
    
}
