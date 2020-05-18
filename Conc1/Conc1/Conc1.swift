//
//  Conc1.swift
//  Conc1
//
//  Created by Patryk Gucik on 14/01/2020.
//  Copyright © 2020 Kamil. All rights reserved.
//

import Foundation

struct Concentration {
    
     var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFacedUp }.theOneAndOnly
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFacedUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFacedUp = (index == newValue) // !!!!!!!!
                
            }
            
        }
    }

    mutating func choseCard(at index: Int )  {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchedIndex = indexOfOneAndOnlyFaceUpCard, matchedIndex != index {
                if cards[matchedIndex] == cards[index] {
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 3
                }
                score -= 1
                cards[index].isFacedUp = true
        } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    var score = 0
    var count = 0

    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Conc1.init (\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
            cards.shuffle()
        }
    }
    
}
extension Collection {
var theOneAndOnly: Element? {
    return count == 1 ? first : nil
    }
}
