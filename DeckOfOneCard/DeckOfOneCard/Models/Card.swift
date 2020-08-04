//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Ian Becker on 8/4/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import Foundation

struct Card: Decodable {
    
    let value: String
    let suit: String
    let image: URL
    
    
}

struct TopLevelObject: Decodable {
    
    let cards: [Card]
    
}
