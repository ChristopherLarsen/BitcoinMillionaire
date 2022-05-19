//
//  HomePresenter.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation
import Combine

class HomePresenter: HomePresenterProtocol {
    
    //MARK: Variables & Constants
    
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    private var cancellables = Set<AnyCancellable>()
    var latestPrice: Double?
    var bitcoinsAvailable: Double?
    
    //MARK: Lifestyle Methods
    
    required init(interactor: HomeInteractorProtocol, router: HomeRouterProtocol = HomeRouter()) {
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: Custom Methods
    
    /// Method to call router to open AddBitcoin View
    func addBitCoin() {
        router?.openAddBitCoinView()
    }
    
    /// Method to call router to open SellBitcoin View
    func sellBitCoin() {
        router?.openSellBitCoinView()
    }
    
    /// Method to call interactor to check latest bitcoin price
    func checkLatestBitcoinPrice() {
        interactor?.checkLatestBitcoinPrice()
    }
    
    /// Method to call interactor to check if user is a millionaire
    func checkIfIAmAMillionaire() {
        interactor?.checkIfIAmAMillionaire()
    }
}
