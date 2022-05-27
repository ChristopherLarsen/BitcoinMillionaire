//
//  WebServiceIntegrationTests.swift
//  BitcoinMillionaireTests
//
//  Created by Jorge Mattei on 5/26/22.
//

import XCTest
import Combine
@testable import BitcoinMillionaire

class WebServiceIntegrationTests: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()
 
    
    func testWebService_WhenRequestingLatestPriceEndpointWithAPIResponseAsType_ShouldReturnAPIResponse() throws {
        //Arrange
        let sut = WebService()
        //Act
        let publisher = sut.get(endpoint: Endpoint.getLatestBitcoinPrice, responseType: APIResponse.self)
        //Assert
        let expectation = expectation(description: "expecting api response")
        publisher.sink {
            switch $0 {
            case .finished: break
            case .failure(let error):XCTFail(error.localizedDescription)
            }
        } receiveValue: { _ in
            XCTAssertTrue(true)
            expectation.fulfill()
        }
        .store(in: &subscriptions)
        waitForExpectations(timeout: 10)
    }
    
    func testWebService_WhenRequestingLatestPriceEndpointWithWrongTypeAsType_ShouldReturnError() throws {
        //Arrange
        let sut = WebService()
        //Act
        let publisher = sut.get(endpoint: Endpoint.getLatestBitcoinPrice, responseType: MockWrongResponse.self)
        //Assert
        let expectation = expectation(description: "expecting api response")
        publisher.sink {
            switch $0 {
            case .finished: break
            case .failure(_):
                XCTAssertTrue(true)
                expectation.fulfill()
            }
        } receiveValue: { _ in
            XCTFail("Should throw Error")
            expectation.fulfill()
        }
        .store(in: &subscriptions)
        waitForExpectations(timeout: 10)
    }

}
