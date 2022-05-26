//
//  Notification+Extensions.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-26.
//

import Foundation


extension Notification.Name {
    
    static let userBitcoinUpdate: Notification.Name  = Notification.Name(rawValue: "userBitcoinUpdate")
    static let bitcoinPriceUpdate: Notification.Name  = Notification.Name(rawValue: "bitcoinPriceUpdate")

}
