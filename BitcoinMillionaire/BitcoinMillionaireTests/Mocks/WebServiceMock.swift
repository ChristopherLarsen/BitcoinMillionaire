//
//  WebServiceMock.swift
//  BitcoinMillionaireTests
//
//  Created by Jorge Mattei on 5/23/22.
//

import Foundation
@testable import BitcoinMillionaire
import Combine


class WebServiceSuccessfulMock : WebServiceProtocol {
    let responseData : Data
    
    init(responseData : Data) {
        self.responseData = responseData
    }
    
    func get<T>(endpoint: EndpointProtocol, responseType: T.Type) -> AnyPublisher<T, Error> where T : ResponseProtocol {
        return Just(responseData)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


class WebServiceErrorMock : WebServiceProtocol {
    
    init() { }
    
    func get<T>(endpoint: EndpointProtocol, responseType: T.Type) -> AnyPublisher<T, Error> where T : ResponseProtocol {
        return Fail(error: WebServiceErrorMockError.defaultError) 
            .eraseToAnyPublisher()
    }
    
    enum WebServiceErrorMockError : Error {
        case defaultError
    }
}
