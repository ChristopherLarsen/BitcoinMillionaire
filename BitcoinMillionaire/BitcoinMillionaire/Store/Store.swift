//
//  Store.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-06-01.
//

import Foundation
import ReSwift

/// The Main ReSwift Store
///
let mainStore = Store<State>(
    reducer: reducer,
    state: nil
)
