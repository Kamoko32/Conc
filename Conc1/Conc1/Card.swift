//
//  Card.swift
//  Conc1
//
//  Created by Patryk Gucik on 14/01/2020.
//  Copyright © 2020 Kamil. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var hashValue: Int {return indetifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool{
        return lhs.indetifier == rhs.indetifier
    }
    var isFacedUp = false
    var isMatched = false
    private var indetifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        indetifier = Card.getUniqueIdentifier()
    }
    
    
}
