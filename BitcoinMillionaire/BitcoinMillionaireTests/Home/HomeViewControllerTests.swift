//
//  HomeViewControllerTests.swift
//  BitcoinMillionaireTests
//
//  Created by Karan Bhasin on 18/05/22.
//

import XCTest
@testable import BitcoinMillionaire

class HomeViewControllerTests: XCTestCase {

    var systemUnderTest: HomeViewController!
    var homeInteractor: HomeInteractorProtocol!
    var homePresenter: HomePresenterProtocol!
    
    override func setUpWithError() throws {
        homeInteractor = MockHomeInteractor()
        homePresenter = MockHomePresenter(interactor: homeInteractor)
        systemUnderTest = HomeViewController(presenter: homePresenter)
        systemUnderTest.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        systemUnderTest = nil
    }
    
    func testInitWithCoder() {
        let homeView = HomeViewController(coder: NSCoder())
        XCTAssertNil(homeView)
    }

    func testHomeViewController_WhenCreated_HasPresenterSetup() {
        XCTAssertTrue(systemUnderTest.presenter != nil, "Presenter was supposed to setup post HomeViewController initialization, But its not present.")
    }
    
    func testHomeViewController_WhenCreated_HasCreatedLatestPriceLabel() throws {
        let latestPriceLabel = try XCTUnwrap(systemUnderTest.latestPriceLabel, "Label not created")
        sleep(1)
        XCTAssertEqual(latestPriceLabel.text, "Latest Price: $0.0")
    }
    
    func testHomeViewController_WhenCreated_hasCreatedBitcoinView() throws {
        let bitcoinContainerView = try XCTUnwrap(systemUnderTest.bitcoinContainerView, "Container view not created")
        let numberOfCoinsLabel = try XCTUnwrap(systemUnderTest.numberOfCoinsLabel, "Number of coins Label not created")
        
        XCTAssertEqual(bitcoinContainerView.layer.accessibilityLabel, "bitcoinContainerView")
        XCTAssertEqual(numberOfCoinsLabel.text, "Bitcoins: 0.0")
    }
    
    func testHomeViewController_WhenCreated_createButtonsStack() throws {
        let stackView = try XCTUnwrap(systemUnderTest.buttonStack, "Button stack not created")
        XCTAssertTrue((stackView.arrangedSubviews[0] as? UIButton) != nil, "stackView Subview was supposed to be a button")
        XCTAssertTrue((stackView.arrangedSubviews[1] as? UIButton) != nil, "stackView Subview was supposed to be a button")
        XCTAssertTrue((stackView.arrangedSubviews[2] as? UIButton) != nil, "stackView Subview was supposed to be a button")
        
        let button1 = stackView.arrangedSubviews[0] as? UIButton
        XCTAssertEqual(button1?.titleLabel?.text, "Add Bitcoin")
        
        let button2 = stackView.arrangedSubviews[1] as? UIButton
        XCTAssertEqual(button2?.titleLabel?.text, "Sell Bitcoin")

        let button3 = stackView.arrangedSubviews[2] as? UIButton
        XCTAssertEqual(button3?.titleLabel?.text, "Check Latest Price")

    }
    
    func testHomeViewController_WhenCreated_checkMillinaireButtonCreated() throws {
        let checkMillionaireButton = try XCTUnwrap(systemUnderTest.millionaireButton, "Check Millionaire Button not created")
        XCTAssertEqual(checkMillionaireButton.titleLabel?.text, "Am I a Millionaire?")

    }
    
    func testHomeViewController_WhenCheckPriceTapped_CheckLatestBitcoinPriceInPresenterMethodIsCalled() throws {
        let stackView = try XCTUnwrap(systemUnderTest.buttonStack, "Button stack not created")
        let button3 = stackView.arrangedSubviews[2] as? UIButton
        XCTAssertEqual(button3?.titleLabel?.text, "Check Latest Price")
        button3?.sendActions(for: .touchUpInside)
        if let presenter = homePresenter as? MockHomePresenter {
            XCTAssertTrue(presenter.checkLatestBitcoinPriceCalled)
        }
    }
    
    func testHomeViewController_WhenCheckForMillionaireTapped_CheckIfIAmAMillionaireInPresenterMethodIsCalled() throws {
        let checkMillionaireButton = try XCTUnwrap(systemUnderTest.millionaireButton, "Check Millionaire Button not created")
        checkMillionaireButton.sendActions(for: .touchUpInside)
        if let presenter = homePresenter as? MockHomePresenter {
            XCTAssertTrue(presenter.checkIfIAmAMillionaireCalled)
        }
    }
    
    func testHomeViewController_addBitcoinTapped_AddBitcoinInPresenterMethodIsCalled() throws {
        let stackView = try XCTUnwrap(systemUnderTest.buttonStack, "Button stack not created")
        let addBitcoinButton = stackView.arrangedSubviews[0] as? UIButton
        addBitcoinButton?.sendActions(for: .touchUpInside)
        if let presenter = homePresenter as? MockHomePresenter {
            XCTAssertTrue(presenter.addBitcoinCalled)
        }
    }
    
    func testHomeViewController_WhensellBitcoinTapped_SellBitcoinInPresenterMethodIsCalled() throws {
        let stackView = try XCTUnwrap(systemUnderTest.buttonStack, "Button stack not created")
        let sellBitcoinButton = stackView.arrangedSubviews[1] as? UIButton
        sellBitcoinButton?.sendActions(for: .touchUpInside)
        if let presenter = homePresenter as? MockHomePresenter {
            XCTAssertTrue(presenter.sellBitcoinCalled)
        }
    }

    // MARK: - Navigation Tests
    
    func xtestHomeViewController_WhenTapBuyBitcoin_ShouldNavigateToAddBitcoinScreen() {
        XCTFail("Failed - Should have navigated to AddBitcoin Screen")
    }

    func xtestHomeViewController_WhenTapRemoveBitcoin_ShouldNavigateToRemoveBitcoinScreen() {
        XCTFail("Failed - Should have navigated to RemoveBitcoin Screen")
    }

    func xtestHomeViewController_WhenTapMillionaire_ShouldNavigateToMillionaireScreen() {
        XCTFail("Failed - Should have navigated to Millionaire Screen")
    }

}
