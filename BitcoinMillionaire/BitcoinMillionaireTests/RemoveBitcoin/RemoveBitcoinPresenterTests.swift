//
//  RemoveBitcoinPresenterTests.swift
//  BitcoinMillionaireTests
//
//  Created by Rakesh Kumar on 2022-05-27.
//

import XCTest
@testable import BitcoinMillionaire

class RemoveBitcoinPresenterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRemoveBitcoinPresenter_WhenRemovingBitcoin_ShouldReturnSuccess() throws {
        //Arrange
        let interactor = RemoveBitcoinInteractorMock(shouldThrowError: false)
        let sut = RemoveBitcoinPresenter(interactor: interactor)
        //Act
        switch sut.removeBitcoin(amount: 1.0) {
        case .success(_):
            XCTAssert(true, "Invalid amount added")
        case .failure(let error) :
            XCTFail(error.localizedDescription)
        }
    }
    
    func testRemoveBitcoinPresenter_WhenRemovingNegativeBitcoin_ShouldReturnSuccess() throws {
        //Arrange
        let interactor = RemoveBitcoinInteractorMock(shouldThrowError: true)
        let sut = RemoveBitcoinPresenter(interactor: interactor)
        //Act
        switch sut.removeBitcoin(amount: -1.0) {
        case .success(_):
            XCTFail("Validation Passed")
        case .failure(let error) :
            XCTAssert(true, error.localizedDescription)
        }
    }
    
    func testRemoveBitcoinPresenter_WhenDisplayingError_DisplayedViewControllerShouldShowAlert() throws {
        //Arrange
        let interactor = RemoveBitcoinInteractorMock(shouldThrowError: true)
        let window = UIWindow()
        let removeBitcoinViewController = RemoveBitcoinViewController()
        let nav = UINavigationController(rootViewController: removeBitcoinViewController)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        let sut = RemoveBitcoinPresenter(interactor: interactor)
        let error = UserBitcoinServiceError.cannotAddZeroOrNegativeAmount
        //Act
        sut.showErrorMessage(error, on: nav, animated: false)
        //Assert
        XCTAssert(nav.presentedViewController is UIAlertController, "AlertNotDisplaying")

    }
}
