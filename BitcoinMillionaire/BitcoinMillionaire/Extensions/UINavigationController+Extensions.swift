//
//  UINavigationController+Extensions.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-25.
//

import Foundation
import UIKit


extension UINavigationController {
    
    static var rootNavigationController: UINavigationController? {
        
        guard let keySceneWindow = UIApplication.shared.keySceneWindow else {
            print("Failed to get the Root NavigationController")
            return nil
        }
        
        guard let rootViewController = keySceneWindow.rootViewController else {
            print("Failed to get the Root NavigationController")
            return nil
        }

        guard let rootNavigationController = rootViewController as? UINavigationController else {
            print("Failed to get the Root NavigationController")
            return nil
        }
        
        return rootNavigationController
        
    }
    
}
