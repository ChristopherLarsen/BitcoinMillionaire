//
//  WebServiceProtocol.swift
//  BitcoinMillionaire
//
//  Created by Jorge Mattei on 5/19/22.
//

import Foundation
import Combine

protocol WebServiceProtocol {
    
    func get<T : ResponseProtocol >(endpoint : EndpointProtocol, responseType: T.Type) -> AnyPublisher<T, Error>
    
}
