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

    // MARK: - Is Called Variables
    //
    var isCalledCheckIfUserIsBitcoinMillionaire: Bool = false
    var isCalledCalculatedUser: Bool = false

    func calculatedUser(isMillionaire: Bool) {
        isCalledCalculatedUser = true
    }
    
    func checkIfUserIsBitcoinMillionaire() {
        isCalledCheckIfUserIsBitcoinMillionaire = true
    }
    
    init() {
    }
    
}
