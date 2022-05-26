//
//  MockMillionaireRouter.swift
//  BitcoinMillionaireTests
//
//  Created by Christopher Larsen on 2022-05-24.
//

import Foundation
@testable import BitcoinMillionaire

class MockMillionaireRouter : MillionaireRouterProtocol {
    
    var millionairePresenter: MillionairePresenterProtocol?

    // MARK: - Is Called Methods
    //         These record whether the method referred to was called on the mock object.
    //
    var isCalledNavigateBack: Bool = false

    func navigateBack() {
        isCalledNavigateBack = true
    }

}
