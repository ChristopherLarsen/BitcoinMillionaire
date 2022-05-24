//
//  DatabaseServiceTests.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-19.
//

import XCTest
@testable import BitcoinMillionaire


class DatabaseServiceTests: XCTestCase {

    var sut: DatabaseRepositoryProtocol!
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

    func testDatabaseService_WhenCreatedWithMockUserDefaults_ShouldHaveMockUserDefaults() {

        // Arrange

        let testString = "TestString"
        
        UserDefaults.standard.set(testString, forKey: testKey)

        // Act

        let result = sut.read(key: testKey)

        // Assert
        
        if case .success(_) = result {
            XCTFail("Failed - Should not have retrieved a value from the real UserDefaults")
        }
        
    }
    
    func testDatabaseService_WhenCreatingObject_ShouldSaveObjectInUserDefaults() {
        
        // Arrange
        
        mockUserDefaults.clearUserDefaults()
        
        let testObject = "TestObject"

        // Act
        
        let result = sut.create(key: testKey, object: testObject)
        
        // Assert

        guard result == .success(true) else {
            XCTFail("Failed - The save operation did not succeed.")
            return
        }
        
        guard let retrieveObject = mockUserDefaults.object(forKey: testKey) as? String else {
            XCTFail("Failed - Did not store test object as correct type.")
            return
        }
        
        XCTAssertTrue(testObject == retrieveObject, "Failed - Did not store the test object in Mock User Defaults.")
        
    }
    
    func testDatabaseService_WhenReadingObject_ShouldReturnObjectFromUserDefaults() {
        
        // Arrange
        
        let testObject = "TestObject"

        mockUserDefaults.clearUserDefaults()
        mockUserDefaults.set(testObject, forKey: testKey)
        
        // Act
        
        let result = sut.read(key: testKey)
        
        // Assert

        switch result {
        case .success(let objectRetrieved):
            if let objectRetrieved = objectRetrieved as? String {
                XCTAssertTrue(objectRetrieved == testObject, "Failed - The object retrieved is not the expected test object.")
            } else {
                XCTFail("Failed - The read operation did not return the expected type of string object.")
            }
        case .failure(let databaseError):
            XCTFail("Failed - The read operation did not succeed. \(databaseError)")
        }
        
    }
    
    func testDatabaseService_WhenReadingObjectThatDoesntExist_ShouldReturnDatabaseError() {
        
        // Arrange
        
        mockUserDefaults.clearUserDefaults()
        
        // Act
        
        let result = sut.read(key: testKey)
        
        // Assert

        switch result {
        case .success(let objectRetrieved):
            XCTFail("Failed - The read operation should not have returned an object. \(objectRetrieved)")
        case .failure(let databaseError):
            XCTAssertTrue(databaseError == .objectDoesNotExist, "Failed - The database error should have been objectDoesNotExist.")
        }
        
    }
    
    func testDatabaseService_WhenUpdatingObject_ShouldUpdateObjectInUserDefaults() {
        
        // Arrange
        
        let testObjectOld = "TestObjectOld"
        let testObjectNew = "TestObjectNew"

        mockUserDefaults.clearUserDefaults()
        mockUserDefaults.set(testObjectOld, forKey: testKey)
        
        // Act
        
        let result = sut.update(key: testKey, object: testObjectNew)
        
        // Assert

        guard result == .success(true) else {
            XCTFail("Failed - The update operation did not succeed.")
            return
        }
        
        guard let retrieveObject = mockUserDefaults.object(forKey: testKey) as? String else {
            XCTFail("Failed - Did not update test object as correct type.")
            return
        }
        
        XCTAssertTrue(retrieveObject == testObjectNew, "Failed - Did not update the test object in Mock User Defaults.")
        
    }
    
    func testDatabaseService_WhenUpdatingObjectThatDoesNotExist_ShouldReturnDatabaseError() {
        
        // Arrange
        
        let testObjectNew = "TestObjectNew"

        mockUserDefaults.clearUserDefaults()
        
        // Act
        
        let result = sut.update(key: testKey, object: testObjectNew)
        
        // Assert

        switch result {
        case .success(let updated):
            XCTFail("Failed - The object should not have been updated. \(updated)")
        case .failure(let databaseError):
            XCTAssertTrue(databaseError == .objectDoesNotExist, "Failed - Did not return the correct DatabaseError type.")
        }
        
        if let retrieveObject = mockUserDefaults.object(forKey: testKey) as? String {
            XCTFail("Failed - Should not be an object in the MockUserDefaults after update. \(retrieveObject)")
        }
        
    }
    
    func testDatabaseService_WhenDeletingObject_ShouldRemoveObjectFromUserDefaults() {
        
        // Arrange
        
        let testObject = "TestObject"

        mockUserDefaults.clearUserDefaults()
        mockUserDefaults.set(testObject, forKey: testKey)
        
        // Act
        
        let result = sut.delete(key: testKey)
        
        // Assert

        switch result {
        case .failure(let databaseError):
            XCTFail("Failed - The update operation did not succeed. \(databaseError)")
        case .success(let deleted):
            XCTAssertTrue(deleted == true, "Failed - The Delete operation did not succeed.")
        }
        
    }
    
    func testDatabaseService_WhenDeletingObjectThatDoesNotExist_ShouldReturnDatabaseError() {
        
        // Arrange
        
        mockUserDefaults.clearUserDefaults()
        
        // Act
        
        let result = sut.delete(key: testKey)
        
        // Assert

        switch result {
        case .failure(let databaseError):
            XCTAssertTrue(databaseError == .objectDoesNotExist, "Failed - The DatabaseError type is not correct.")
        case .success(let deleted):
            XCTFail("Failed - The delete operation should not have succeed. \(deleted)")
        }
        
    }
    
}
