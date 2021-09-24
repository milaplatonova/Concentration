//
//  Card.swift
//  Concentration
//
//  Created by Lyudmila Platonova on 5/23/20.
//  Copyright © 2020 Lyudmila Platonova. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUnicIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init () {
        self.identifier = Card.getUnicIdentifier()
    }
}
