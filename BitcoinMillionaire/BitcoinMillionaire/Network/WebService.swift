//
//  WebService.swift
//  BitcoinMillionaire
//
//  Created by Jorge Mattei on 5/19/22.
//

import Foundation
import Combine

class WebService: WebServiceProtocol {
    
    var urlSession : URLSession
    
    init(urlSession : URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func get<T:ResponseProtocol>(endpoint : EndpointProtocol, responseType: T.Type) -> AnyPublisher<T, Error>  {
        let url = URL(string: endpoint.urlString)!
        return urlSession.dataTaskPublisher(for: url)
            .map({
                print(String(data: $0.data, encoding: .utf8)!)
                return $0.data 
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}

protocol EndpointProtocol  {
    var urlString : String { get }
}
 
enum Endpoint: EndpointProtocol  {
    case getLatestBitcoinPrice
    
    var urlString : String {
        switch self {
        case .getLatestBitcoinPrice:
            return Constants.WebService.bitcoinPriceEndpoint
        }
    }
}
