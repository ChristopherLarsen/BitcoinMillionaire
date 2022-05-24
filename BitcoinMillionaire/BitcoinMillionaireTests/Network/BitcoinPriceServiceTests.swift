//
//  WebServiceTests.swift
//  BitcoinMillionaireTests
//
//  Created by Jorge Mattei on 5/19/22.
//

import XCTest
import Combine
@testable import BitcoinMillionaire

class BitcoinPriceServiceTests: XCTestCase {
     
    var cancellables : Set<AnyCancellable> = []
    
    override func setUp() {
        cancellables = []
    }
    
    func testBitcoinPriceService_WhenGivenSuccessfulResponse_ReturnsSuccess() throws {
        //Arrange
        let responseData = successfulResponse.data(using: .utf8) ?? Data()
        let sut = BitcoinPriceService(webService: WebServiceSuccessfulMock(responseData: responseData))
        let serviceExpectation = expectation(description: "Bitcoin price service response expectation ")
        //Act
        sut.getLatest()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    XCTFail(error.localizedDescription)
                    serviceExpectation.fulfill()
                case .finished:
                    print("finished")
                }
            } receiveValue: {
                XCTAssertNotNil($0)
                serviceExpectation.fulfill()
            }
            .store(in: &cancellables)
        //Assert
        wait(for: [serviceExpectation], timeout: 10, enforceOrder: true)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

fileprivate let successfulResponse = """
{"time":{"updated":"May 19, 2022 21:19:00 UTC","updatedISO":"2022-05-19T21:19:00+00:00","updateduk":"May 19, 2022 at 22:19 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","chartName":"Bitcoin","bpi":{"USD":{"code":"USD","symbol":"&#36;","rate":"30,389.2112","description":"United States Dollar","rate_float":30389.2112},"GBP":{"code":"GBP","symbol":"&pound;","rate":"24,834.7928","description":"British Pound Sterling","rate_float":24834.7928},"EUR":{"code":"EUR","symbol":"&euro;","rate":"29,229.7109","description":"Euro","rate_float":29229.7109}}}
"""
 

