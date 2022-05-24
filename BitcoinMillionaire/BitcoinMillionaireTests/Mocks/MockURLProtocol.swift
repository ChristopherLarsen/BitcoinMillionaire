//
//  MockURLProtocol.swift
//  BitcoinMillionaireTests
//
//  Created by Jorge Mattei on 5/19/22.
//

import Foundation


class MockURLProtocol : URLProtocol {
    
    static var stubResponseData : Data?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    
    override func stopLoading() { 
    }
    
    
}
