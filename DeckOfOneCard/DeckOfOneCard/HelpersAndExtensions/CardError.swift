//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by Ian Becker on 8/4/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import Foundation

enum CardError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    
    var errorDescription: String? {
    switch self {
    case .invalidURL:
        return "Unable to reach the server. Invalid URL."
    case .thrownError(let error):
        return error.localizedDescription
    case .noData:
        return "The server responded with no data."
        }
    }
}
