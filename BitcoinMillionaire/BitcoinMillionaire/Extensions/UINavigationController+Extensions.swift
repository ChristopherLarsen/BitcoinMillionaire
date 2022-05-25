//
//  UINavigationController+Extensions.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-25.
//

import Foundation
import UIKit


extension UINavigationController {
    
    static var rootNavigationController: UINavigationController {
        
        guard let window = UIApplication.shared.keyWindow else {
            fatalError("Failed to get the Window")
        }
        
        guard let rootViewController = window.rootViewController else {
            fatalError("Failed to get the Root NavigationController")
        }

        guard let rootNavigationController = rootViewController as? UINavigationController else {
            fatalError("Failed to get the Root NavigationController")
        }
        
        return rootNavigationController
        
    }
    
}
