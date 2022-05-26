//
//  MockMillionaireViewController.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-26.
//

import Foundation
import Combine
@testable import BitcoinMillionaire


class MockMillionaireViewController : MillionaireViewControllerProtocol {
    
    var isBitcoinMillionaire: PassthroughSubject<Bool, Never> {
        get {
            isCalledIsBitcoinMillionaire = true
            return _isBitcoinMillionaire
        }
        set {
            
        }
    }
    
    private var _isBitcoinMillionaire: PassthroughSubject<Bool, Never> = PassthroughSubject<Bool, Never>()
    
    // MARK: - Is Called Methods
    //         These record whether the method referred to was called on the mock object.
    //
    var isCalledIsBitcoinMillionaire: Bool = false
    
}
