//
//  HomePresenterProtocol.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 19/05/22.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    init(interactor: HomeInteractorProtocol, router: HomeRouterProtocol)
    func addBitCoin()
    func sellBitCoin()
    func checkNumberOfCoinsAvailable()
    func checkLatestBitcoinPrice()
    func checkIfIAmAMillionaire()
}


