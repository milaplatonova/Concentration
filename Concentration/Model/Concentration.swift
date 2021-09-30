//
//  Concentration.swift
//  Concentration
//
//  Created by Lyudmila Platonova on 5/23/20.
//  Copyright © 2020 Lyudmila Platonova. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards: [Card] = []
    var indexOfOneAndOnlyFaceUpCard: Int?
    var flipCount = 0
    var score = 0
    var chosenCards: [Int] = []
    
    func chooseCard (at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else if chosenCards.contains(index)  {
                    score -= 1
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                if chosenCards.contains(index) {
                    score -= 1
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func restartGame () {
        cards = cards.shuffled()
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            chosenCards = []
            indexOfOneAndOnlyFaceUpCard = nil
        }
    }
    
    init (numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
         for _ in 1...Int.random(in: 1...8) {
            cards = cards.shuffled()
        }
    }
    
}
