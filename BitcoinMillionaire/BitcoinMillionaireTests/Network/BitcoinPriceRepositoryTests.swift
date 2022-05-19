//
//  WebServiceTests.swift
//  BitcoinMillionaireTests
//
//  Created by Jorge Mattei on 5/19/22.
//

import XCTest
import Combine
@testable import BitcoinMillionaire

class BitcoinPriceRepositoryTests: XCTestCase {
     
    var cancellables : Set<AnyCancellable> = []
    
    override func setUp() {
        cancellables = []
    }
    
    func testBitcoinPriceRepository_WhenGivenSuccessfulResponse_ReturnsSuccess() throws {
        //Arrange
        let sut = BitcoinPriceService()
        let repositoryExpectation = expectation(description: "Bitcoin price resposne expectation ")
        //Act
        sut.getLatest()
            .sink { _ in } receiveValue: {
                XCTAssertNotNil($0)
                repositoryExpectation.fulfill()
            }
            .store(in: &cancellables)
        //Assert
        wait(for: [repositoryExpectation], timeout: 10, enforceOrder: true)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
