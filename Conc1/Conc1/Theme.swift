//
//  Theme.swift
//  Conc1
//
//  Created by Kamil Gucik on 15/01/2020.
//  Copyright © 2020 Kamil. All rights reserved.
//

import Foundation

struct Theme {
    var emojiTheme: [String]
    var backgroundTheme: String
    var identifier: Int
    
    static var idientifierTheme = 0
    
    static func getUniqueIdentifier() -> Int {
        idientifierTheme += 1
        return idientifierTheme
    }
    
    init(addEmoji emoji: [String], setBackGround background: String) {
        emojiTheme = emoji
        backgroundTheme = background
        identifier = Theme.getUniqueIdentifier()
    }
}
