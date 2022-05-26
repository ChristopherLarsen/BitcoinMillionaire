//
//  AddBitcoinInteractorTests.swift
//  BitcoinMillionaireTests
//
//  Created by Jorge Mattei on 5/26/22.
//

import XCTest
@testable import BitcoinMillionaire

class AddBitcoinInteractorTests: XCTestCase {
    
    func testAddBitcoinInteractor_WhenAddingPositiveAmountOfBitcoin_ShouldReturnTrue() throws {
        //Arrange
        let service = UserBitcoinService(database: MockDatabase(userDefaults: .init()))
        let sut = AddBitcoinInteractor(userBitcoinService: service)
        //Act
        let amount : Double = 1.0
        let result = sut.addBitcoin(amount: amount)
        //Assert
        switch result {
        case .success(let success): XCTAssert(success)
        case .failure(let error) : XCTFail(error.localizedDescription)
        }
    }
    
    func testAddBitcoinInteractor_WhenGivingANegativeAmoungOfBitcoin_ShouldThrowError() throws {
        //Arrange
        let service = UserBitcoinService(database: MockDatabase(userDefaults: .init()))
        let sut = AddBitcoinInteractor(userBitcoinService: service)
        //Act
        let amount : Double = -1.0
        let result = sut.addBitcoin(amount: amount)
        //Assert
        switch result {
        case .success(_): XCTFail("Should throw Error")
        case .failure(_) :XCTAssert(true, "Should throw Error")
        }
    }
    
    func testAddBitcoinInteractor_WhenGivingZeroBitcoin_ShouldThrowError() throws {
        //Arrange
        let service = UserBitcoinService(database: MockDatabase(userDefaults: .init()))
        let sut = AddBitcoinInteractor(userBitcoinService: service)
        //Act
        let amount : Double = 0.0
        let result = sut.addBitcoin(amount: amount)
        //Assert
        switch result {
        case .success(_): XCTFail("Should throw Error")
        case .failure(_) :XCTAssert(true, "Should throw Error")
        }
    }

}
