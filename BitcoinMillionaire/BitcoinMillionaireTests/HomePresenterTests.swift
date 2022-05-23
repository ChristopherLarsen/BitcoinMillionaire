//
//  HomePresenterTests.swift
//  BitcoinMillionaireTests
//
//  Created by Karan Bhasin on 19/05/22.
//

import XCTest
@testable import BitcoinMillionaire

class HomePresenterTests: XCTestCase {
    var systemUnderTest: HomePresenter!
    var homeInteractor: HomeInteractorProtocol!
    var homeRouter: HomeRouterProtocol!
    
    override func setUpWithError() throws {
        homeInteractor = MockHomeInteractor()
        homeRouter = MockHomeRouter()
        systemUnderTest = HomePresenter(interactor: homeInteractor,router: homeRouter)
    }

    override func tearDownWithError() throws {
        //homeIneteractor = nil
        systemUnderTest = nil
    }

    func testHomePresenter_WhenCreated_InteractorIsPassed() {
        XCTAssertTrue(systemUnderTest.interactor != nil, "Home Interactor was supposed to be passed while initializing HomePresenter, but looks like its not there.")
    }
    
    func testHomePresenter_WhenAddBitCoinMethodIsCalledByUI_AddBitCoinMethodOnRouterIsCalled() {
        systemUnderTest.interactor = homeInteractor
        systemUnderTest.addBitCoin()
        guard let homeRouter = homeRouter as? MockHomeRouter else {
            XCTAssertTrue(homeRouter == nil)
            return
        }
        XCTAssertTrue(homeRouter.addBitCoinViewOpened)
    }
    
    func testHomePresenter_WhenSellBitCoinMethodIsCalledByUI_SellBitCoinMethodOnRouterIsCalled() {
        systemUnderTest.interactor = homeInteractor
        systemUnderTest.sellBitCoin()
        guard let homeRouter = homeRouter as? MockHomeRouter else {
            XCTAssertTrue(homeRouter == nil)
            return
        }
        XCTAssertTrue(homeRouter.sellBitCoinViewOpened)
    }

    func testHomePresenter_WhencheckLatestBitcoinPriceMethodIsCalledByUI_checkLatestBitcoinPriceMethodOnInetractorIsCalled() {
        systemUnderTest.interactor = homeInteractor
        systemUnderTest.checkLatestBitcoinPrice()
        guard let homeInteractor = homeInteractor as? MockHomeInteractor else {
            XCTAssertTrue(homeInteractor == nil)
            return
        }
        XCTAssertTrue(homeInteractor.checkLatestBitcoinPriceInInteractorCalled)
    }

    func testHomePresenter_WhencheckIfIAmAMillionaireMethodIsCalledByUI_checkIfIAmAMillionaireMethodOnInetractorIsCalled() {
        systemUnderTest.interactor = homeInteractor
        systemUnderTest.checkIfIAmAMillionaire()
        guard let homeInteractor = homeInteractor as? MockHomeInteractor else {
            XCTAssertTrue(homeInteractor == nil)
            return
        }
        XCTAssertTrue(homeInteractor.checkIfIAmAMillionaireInInteractorCalled)
    }


}