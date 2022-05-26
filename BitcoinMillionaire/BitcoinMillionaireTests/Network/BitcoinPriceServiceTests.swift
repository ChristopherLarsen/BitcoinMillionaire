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
        let responseData = bitcoinPriceServiceCorrectResponseStub.data(using: .utf8) ?? Data()
        let sut = BitcoinPriceService(webService: WebServiceSuccessfulMock(responseData: responseData))
        let serviceExpectation = expectation(description: "Bitcoin price service response expectation ")
        //Act
        sut.getLatest()
            .sink { completion in
                switch completion {
                case .failure(let error):
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
    
    func testBitcoinPriceService_WhenWrongResponse_ReturnsError() throws {
        //Arrange
        let responseData = bitcoinPriceServiceWrongResponseStub.data(using: .utf8) ?? Data()
        let sut = BitcoinPriceService(webService: WebServiceSuccessfulMock(responseData: responseData))
        let serviceExpectation = expectation(description: "Bitcoin price service response expectation ")
        //Act
        sut.getLatest()
            .sink { completion in
                switch completion {
                case .failure(_):
                    XCTAssertTrue(true)
                    serviceExpectation.fulfill()
                case .finished:
                    print("finished")
                }
            } receiveValue: { _ in
                XCTFail("Correct Response received")
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

 

