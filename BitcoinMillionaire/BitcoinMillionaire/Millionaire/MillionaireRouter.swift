//
//  MillionaireRouter.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-24.
//

import Foundation
import UIKit

// MARK: - MillionaireRouterProtocol

protocol MillionaireRouterProtocol {
    var millionairePresenter: MillionairePresenterProtocol? { get set }
    func navigateBack()
}

// MARK: - MillionaireRouter

class MillionaireRouter : MillionaireRouterProtocol {
    
    var millionairePresenter: MillionairePresenterProtocol?

    func navigateBack() {

        guard let millionaireViewController = millionairePresenter?.millionaireViewController as? UIViewController else {
            print("Error - No reference to the current UIViewController.")
            return
        }

        guard let navigationController = millionaireViewController.navigationController else {
            print("Error - Current UIViewController does not exist in a Navigation controller.")
            return
        }
        
        navigationController.popViewController(animated: true)
        
    }

}



