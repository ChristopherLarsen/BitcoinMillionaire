//
//  DatabaseServiceTests.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-19.
//

import XCTest
@testable import BitcoinMillionaire


class DatabaseServiceTests: XCTestCase {

    var sut: DatabaseServiceProtocol!
    var mockUserDefaults: MockUserDefaults!
    
    let testKey = "TestKey"

    override func setUpWithError() throws {
    
        mockUserDefaults = MockUserDefaults()
        sut = DatabaseService(userDefaults: mockUserDefaults)
        
    }

    override func tearDownWithError() throws {
        UserDefaults.standard.removeObject(forKey: testKey)
    }
    
    // MARK: - Unit Tests

    func testDatabaseService_WhenCreatedWithMockUserDefaults_HasMockUserDefaults() {
                
        let testString = "TestString"
        
        UserDefaults.standard.set(testString, forKey: testKey)
        
        let result = sut.read(key: testKey)

        if case .success(_) = result {
            XCTFail("Failed - Should not have retrieved a value from the real UserDefaults")
        }
        
    }

}
