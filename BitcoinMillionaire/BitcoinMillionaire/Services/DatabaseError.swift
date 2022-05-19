//
//  DatabaseError.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-19.
//

import Foundation


// MARK: - DatabaseError

enum DatabaseError: Error {
    case objectDoesNotExist
    case failedToDeleteObject
    case unknown
}
