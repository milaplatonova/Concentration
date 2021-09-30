//
//  ViewController.swift
//  Concentration
//
//  Created by Lyudmila Platonova on 5/17/20.
//  Copyright © 2020 Lyudmila Platonova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
    var updatedScore = 0
    
    typealias Theme = (emojiChoices: [String], backgroundColor: UIColor, cardColor: UIColor)
    var emojiChoices: [String] = []
    var emoji: [Int : String] = [:]
    private var backgroundColor = UIColor.black
    private var cardColor = UIColor.orange
    
    private var emojiThemes: [String : Theme] =
        ["halloween" : (["🎃", "👻", "🦇", "🧙🏻‍♀️", "😱", "😈", "🦉", "🕸", "💀", "🧹"], #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)),
         "plants" : (["🌸", "🌼", "🌻", "🌺", "🌷", "🌹", "🌵", "☘️", "🌾", "🌿"], #colorLiteral(red: 1, green: 0.9036896728, blue: 0.9397508947, alpha: 1), #colorLiteral(red: 0.7705623414, green: 0.4794531776, blue: 0.6168625796, alpha: 1)),
         "activities" : (["⛹🏼‍♂️", "🏂", "🏋🏼", "🤺", "🏄🏼‍♀️", "🚴🏼‍♂️", "🏊🏼‍♀️", "⛷", "🏌🏼‍♂️", "🏇🏼"], #colorLiteral(red: 0.7759499422, green: 0.8307985381, blue: 0.8982069547, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)),
         "eat" : (["🥪", "🥞", "🍗", "🧀", "🍳", "🍟", "🍔", "🍕", "🌯", "🥗"], #colorLiteral(red: 0.9764705896, green: 0.9575593692, blue: 0.7933397697, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)),
         "fruits" : (["🍇", "🍉", "🍌", "🍒", "🍐", "🍎", "🍋", "🍊", "🍍", "🥝"], #colorLiteral(red: 0.9234796905, green: 1, blue: 0.8929119125, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.3193748536, blue: 0.2116703386, alpha: 1)),
         "animals" : (["🐖", "🦧", "🐆", "🦓", "🐘", "🐫", "🦒", "🐅", "🐏", "🦌"], #colorLiteral(red: 0.8789888388, green: 0.8875515546, blue: 0.7351931411, alpha: 1), #colorLiteral(red: 0.3351484992, green: 0.4832962488, blue: 0.0344443784, alpha: 1)),
         "faces" : (["😍", "🤩", "😜", "😂", "😃", "😉", "🙃", "🙁", "😭", "😠"], #colorLiteral(red: 1, green: 0.8525543398, blue: 0.5482461299, alpha: 1), #colorLiteral(red: 0.6097635712, green: 0.3450872931, blue: 0.05732504532, alpha: 1)),
         "vagetables" : (["🥒", "🌶", "🌽", "🥕", "🍆", "🧅", "🥦", "🥬", "🧄", "🥔"], #colorLiteral(red: 0.7888919118, green: 0.9087800687, blue: 0.6558412374, alpha: 1), #colorLiteral(red: 0.3887021954, green: 0.720824009, blue: 0.09491572346, alpha: 1)),
         "transport" : (["🚗", "🚒", "🚕", "🚌", "🚎", "🚓", "🚑", "🚜", "✈️", "🚂"], #colorLiteral(red: 0.5438882681, green: 0.5438882681, blue: 0.5438882681, alpha: 1), #colorLiteral(red: 0.8445354179, green: 0.8766179494, blue: 0.863704088, alpha: 1)),
         "christmas" : (["❄️", "⛄️", "⭐️", "🌙", "🎍", "🎄", "🦌", "🎅🏼", "🎁", "🙏🏻"], #colorLiteral(red: 1, green: 0.9427992062, blue: 0.9641471661, alpha: 1), #colorLiteral(red: 0.832677594, green: 0.2583475717, blue: 0.1097568969, alpha: 1)),
         "clothes" : (["👗", "👙", "👖", "👔", "👕", "👚", "🧥", "🩳", "👠", "👟"], #colorLiteral(red: 0.2096268194, green: 0.361507518, blue: 0.5, alpha: 1), #colorLiteral(red: 0.5861548952, green: 0.7324998778, blue: 0.7947136739, alpha: 1))]
    
    private var keys: [String] {
        return Array(emojiThemes.keys)
    }
   
    private var themeIndex = 0 {
        didSet {
            (emojiChoices, backgroundColor, cardColor) = emojiThemes[keys[themeIndex]] ?? ([], .black, .orange)
            emoji = [:]
            updateAppearance()
        }
    }
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        for card in cardButtons {
            card.layer.cornerRadius = 10
        }
        
        newGameButton.buttonCustomization()
        continueButton.buttonCustomization()
        
        deactivateButton(continueButton)
        
        themeIndex = keys.count.arc4random
        updateViewFromModel()
        
    }

    func updateAppearance () {
        view.backgroundColor = backgroundColor
        flipCountLabel.textColor = cardColor
        scoreLabel.textColor = cardColor
        newGameButton.setTitleColor(backgroundColor, for: .normal)
        newGameButton.backgroundColor = cardColor
        continueButton.setTitleColor(backgroundColor, for: .normal)
        continueButton.backgroundColor = cardColor
    }
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        guard let cardNumber = cardButtons.firstIndex(of: sender) else {
            print ("Chosen card was not in cardButtons")
            return
        }
        game.chooseCard(at: cardNumber)
        if !game.chosenCards.contains(cardNumber) {
            game.chosenCards.append(cardNumber)
        }
        updateViewFromModel()
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        newGame()
        game.flipCount = 0
        game.score = 0
        scoreLabel.text = "Score: 0"
        updateViewFromModel()
    }
    
    @IBAction func continueGame(_ sender: UIButton) {
        newGame()
        updateViewFromModel()
    }
    
    func newGame() {
        game.restartGame()
        emojiChoices += emoji.values
        emoji = [:]
        deactivateButton(continueButton)
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: .normal)
        }
        themeIndex = keys.count.arc4random
    }
    
    func deactivateButton (_ button: UIButton) {
        button.isEnabled = false
        if button.titleLabel?.text == "Continue" {
            button.alpha = 0.8
        }
    }
    
    func updateViewFromModel() {
        updatedScore = game.score
        scoreLabel.text = "Score: \(updatedScore)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
        var notMatchedCardsCount = 0
        var faceUpCardsCount =  0
        for card in game.cards {
            if !card.isMatched {
                notMatchedCardsCount += 1
            }
            if card.isFaceUp {
                faceUpCardsCount += 1
            }
        }
        if notMatchedCardsCount == 0 && faceUpCardsCount == 2 {
            continueButton.isEnabled = true
            continueButton.alpha = 1
        }
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji (for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                deactivateButton(button)
            } else {
                button.isEnabled = true
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : cardColor
            }
            if card.isMatched {
                deactivateButton(button)
            }
        }
    }
    
    func emoji (for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    

}
