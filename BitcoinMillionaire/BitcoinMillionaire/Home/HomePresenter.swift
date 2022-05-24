//
//  HomePresenter.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation
import Combine

class HomePresenter: HomePresenterProtocol, ObservableObject {

    //MARK: Variables & Constants
    
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    @Published var latestPrice: Double?
    @Published var bitcoinsAvailable: Double?
    private var subscriptions = Set<AnyCancellable?>()

    //MARK: Lifestyle Methods
    
    required init(interactor: HomeInteractorProtocol, router: HomeRouterProtocol = HomeRouter()) {
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: Custom Methods
    
    /// Method to call router to open AddBitcoin View
    func addBitcoin() {
        router?.openAddBitcoinView()
    }
    
    /// Method to call router to open SellBitcoin View
    func sellBitcoin() {
        router?.openSellBitcoinView()
    }
    
    func checkLatestBitcoinPriceOnline() {
        subscriptions.insert(interactor?.checkLatestBitcoinPrice()
            .sink(receiveCompletion: { _ in}, receiveValue: { price in
                    self.latestPrice = price
                }))
    }
    
    /// Method to call interactor to check latest bitcoin price
    func checkLatestBitcoinPrice() {
        subscriptions.insert(interactor?.checkLatestPriceFromDataBase()
            .sink(receiveCompletion: { _ in}, receiveValue: { price in
                if price == 0.0 {
                    self.checkLatestBitcoinPriceOnline()
                } else {
                    self.latestPrice = price
                }
            }))
    }
    
    
    /// Method to call inetractor to check the number of coins available with the user.
    func checkNumberOfCoinsAvailable() {
        subscriptions.insert(interactor?.checkBitcoinAvailability()
            .sink(receiveCompletion: { _ in}, receiveValue: { bitcoinEntity in
                self.bitcoinsAvailable = Double(bitcoinEntity.bitcoins)
            }))
    }
    
    /// Method to call interactor to check if user is a millionaire
    func checkIfIAmAMillionaire() {
        interactor?.checkIfIAmAMillionaire()
    }
}
