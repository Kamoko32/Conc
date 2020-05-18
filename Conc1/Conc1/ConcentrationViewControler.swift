//
//  ViewController.swift
//  Conc1
//
//  Created by Patryk Gucik on 13/01/2020.
//  Copyright © 2020 Kamil. All rights reserved.
//

import UIKit

class ConcentrationViewControler: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCard)
    
    var numberOfPairsOfCard: Int {
        get {
            return (cardButtons.count+1 ) / 2
        }
    }
    
    var themeChosed: String?
    
    private func changeLabel (_ name: String) {
        themeLabel.text = name
    }

    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var themeLabel: UILabel! {
        didSet {
            changeLabel(themeChosed ?? "TEST")
        }
    }

    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
            
        }
    }
    
    
    var winter = "❄️☃️🥶🎿🏂"
    var holidays = "🏖🏝🎁⛵️🛳"
    var hallowen = "👻🎃🤡👹🧠"
    var tech = "🎥💿🖥📷🖲"
    
     lazy var themes = [winter,holidays,hallowen,tech]
    

    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction private func newGameButton(_ sender: UIButton) {
        flipCountLabel.text = "Flips: 0"
        scoreLabel.text = "Score: 0"
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCard)
        for index in cardButtons.indices {
            game.cards[index].isMatched = false
            game.cards[index].isFacedUp = false
        }
        let random = Int.random(in: 0..<themes.count)
            game.cards.shuffle()
        
        self.emojiChoices = themes[random]
        updateViewFromModel()
        
        switch random {
        case 0:
            themeLabel.text = "Winter"
        case 1:
            themeLabel.text = "Holidays"
        case 2:
            themeLabel.text = "Hallowen"
        case 3:
            themeLabel.text = "Tech"
        default:
            themeLabel.text = "Wrong"
        }
    }
    
    private var emojiChoices = "👻🎃🤡👹🧠💃🏻🦊"
    
    @IBOutlet private var cardButtons: [UIButton]!
        
    @IBAction private func touchButton(_ sender: UIButton) {
        let cardNumber = cardButtons.firstIndex(of: sender)!
        let card = game.cards[cardNumber]
        let button = cardButtons[cardNumber]
        if !card.isFacedUp, button.backgroundColor != #colorLiteral(red: 0.4640117062, green: 0.1698550131, blue: 0.09068201727, alpha: 0)  {
            game.count += 1
        }
        flipCountLabel.text = "Flips: \(game.count)"
        scoreLabel.text = "Score : \(game.score)"
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.choseCard(at: cardNumber)
            updateViewFromModel()
        } else{
            print("chosen card was not in CardButtons")
        }
    }
    
    
    private func updateViewFromModel() {
        if cardButtons != nil {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFacedUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.4640117062, green: 0.1698550131, blue: 0.09068201727, alpha: 0) : UIColor.systemOrange        }
        }
    }
    }
    
    private var emoji = [Card:String]()
    
    private func emoji (for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
            }
    
        return emoji[card] ?? "?"
    }
}
extension Int {
    var arc4random: Int {
        if self > 0 {
        return Int(arc4random_uniform((UInt32)(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform((UInt32)(self)))
        } else {
            return 0
        }
    }
}

