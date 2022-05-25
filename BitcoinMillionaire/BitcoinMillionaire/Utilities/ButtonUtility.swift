//
//  ButtonUtility.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import UIKit

class ButtonUtility {
    
    static func createButton(title: String, backgroundColor: UIColor = .blue) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 5.0
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = backgroundColor
        return button
    }
    
}
