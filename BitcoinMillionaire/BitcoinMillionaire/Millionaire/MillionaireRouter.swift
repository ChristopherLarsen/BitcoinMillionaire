//
//  MillionaireRouter.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-24.
//

import Foundation

// MARK: - MillionaireRouterProtocol

protocol MillionaireRouterProtocol {
    var millionairePresenter: MillionairePresenterProtocol? { get set }
}

// MARK: - MillionaireRouter

class MillionaireRouter : MillionaireRouterProtocol {
    
    var millionairePresenter: MillionairePresenterProtocol?

}



