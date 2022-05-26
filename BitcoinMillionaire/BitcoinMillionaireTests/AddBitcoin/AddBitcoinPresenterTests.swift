//
//  AddBitcoinPresenterTests.swift
//  BitcoinMillionaireTests
//
//  Created by Jorge Mattei on 5/26/22.
//
 
import XCTest
@testable import BitcoinMillionaire

class AddBitcoinPresenterTests: XCTestCase {
     
    
    override class func setUp() {
        
    }
    
    func testAddBitcoinPresenter_WhenAddingBitcoin_ShouldReturnSuccess() throws {
        //Arrange
        let interactor = AddBitcoinInteractorMock(shouldThrowError: false)
        let sut = AddBitcoinPresenter(interactor: interactor)
        //Act
        switch sut.addBitcoin(amount: 1.0) {
        case .success(_):
            XCTAssert(true, "Invalid amount added")
        case .failure(let error) :
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAddBitcoinPresenter_WhenAddinNegativeBitcoin_ShouldReturnSuccess() throws {
        //Arrange
        let interactor = AddBitcoinInteractorMock(shouldThrowError: true)
        let sut = AddBitcoinPresenter(interactor: interactor)
        //Act
        switch sut.addBitcoin(amount: -1.0) {
        case .success(_):
            XCTFail("Validation Passed")
        case .failure(let error) :
            XCTAssert(true, error.localizedDescription)
        }
    }
    
    func testAddBitcoinPresenter_WhenDismissingViewController_ControllerShouldBeDismissed() throws {
        //Arrange
        let interactor = AddBitcoinInteractorMock(shouldThrowError: false)
        let addBitcoinViewController = AddBitcoinViewController()
        let nav = UINavigationController(rootViewController: UIViewController())
        let sut = AddBitcoinPresenter(interactor: interactor)
        nav.pushViewController(addBitcoinViewController, animated: false)
        //Act
        sut.dismiss(addBitcoinViewController, animated: false)
        //Assert
        XCTAssert(nav.topViewController != addBitcoinViewController)
    }
    
    func testAddBitcoinPresenter_WhenDisplayingError_DisplayedViewControllerShouldShowAlert() throws {
        //Arrange
        let interactor = AddBitcoinInteractorMock(shouldThrowError: true)
        let window = UIWindow()
        let addBitcoinViewController = AddBitcoinViewController()
        let nav = UINavigationController(rootViewController: addBitcoinViewController)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        let sut = AddBitcoinPresenter(interactor: interactor)
        let error = UserBitcoinServiceError.cannotAddZeroOrNegativeAmount
        //Act
        sut.showErrorMessage(error, on: nav, animated: false)
        //Assert
        XCTAssert(nav.presentedViewController is UIAlertController, "AlertNotDisplaying")
        
        
        
    }
    
    
}
