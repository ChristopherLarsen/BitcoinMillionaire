//
//  BitcoinReduxTests.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-06-01.
//

import XCTest
@testable import BitcoinMillionaire


class BitcoinReduxTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testBitcoinState_WhenCreated_ShouldStartAtZero() throws {
        
        // Arrange
        
        let mockDatabaseService = MockDatabase()
        
        // Act

        let sut = BitcoinState(bitcoin: nil, databaseService: mockDatabaseService)
        
        // Assert
        
        XCTAssert(sut.bitcoin == 0.0, "Failed - Bitcoin should start at Zero.")
    }

    func testBitcoinState_WhenCreatedWithZero_ShouldStartAtZero() throws {
        
        // Arrange

        let sut = BitcoinState(bitcoin: 0.0)
        
        // Assert
        
        XCTAssert(sut.bitcoin == 0.0, "Failed - Bitcoin should start at Zero.")
    }
    
}
