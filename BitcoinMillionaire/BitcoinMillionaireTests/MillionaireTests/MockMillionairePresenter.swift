//
//  MockMillionairePresenter.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-24.
//

import Foundation
@testable import BitcoinMillionaire

class MockMillionairePresenter : MillionairePresenterProtocol {
    
    var millionaireViewController: MillionaireViewControllerProtocol?

    // MARK: - Is Called Methods
    //         These record whether the method referred to was called on the mock object.
    //
    var isCalledCheckIfUserIsBitcoinMillionaire: Bool = false
    var isCalledCalculatedUser: Bool = false
    var isCalledActionDone: Bool = false

    func calculatedUser(isMillionaire: Bool) {
        isCalledCalculatedUser = true
    }
    
    func checkIfUserIsBitcoinMillionaire() {
        isCalledCheckIfUserIsBitcoinMillionaire = true
    }

    func actionDone() {
        isCalledActionDone = true
    }

    // MARK: init
    
    init() {
    }
    
}
