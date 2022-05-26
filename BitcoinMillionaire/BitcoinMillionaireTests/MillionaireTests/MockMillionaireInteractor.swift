//
//  MockMillionaireInteractor.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-24.
//

import Foundation
@testable import BitcoinMillionaire

class MockMillionaireInteractor : MillionaireInteractorProtocol {
    
    var millionairePresenter: MillionairePresenterProtocol?
    
    // MARK: -  Is Called Methods
    //          These record whether the method referred to was called on the mock object.
    //
    var isCalledCalculateUserBitcoinMillionaireStatus = false
    
    required init(millionairePresenter: MillionairePresenterProtocol = MockMillionairePresenter()) {
        self.millionairePresenter = millionairePresenter
    }
    
    func calculateUserBitcoinMillionaireStatus() {
        isCalledCalculateUserBitcoinMillionaireStatus = true
    }
    
}
