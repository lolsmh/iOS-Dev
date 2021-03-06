//
//  EmojieMemoryGame.swift
//  Memorize
//
//  Created by Даниил Апальков on 29.11.2020.
//

import SwiftUI

class EmojieMemoryGame: ObservableObject {
    @Published private var model = createMemoryGame()
    
    private  static func createMemoryGame() -> MemoryGame<String> {
        let emojies = ["👻", "🎃", "👺", "👾", "👁", "🐐", "🤖", "🦋", "♥️"]
        var game = MemoryGame<String>(numberOfPairsOfCards: emojies.count) { index in
            return emojies[index]
        }
        return game.shuffle()
    }
    
    //MARK: - Access to the Model
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojieMemoryGame.createMemoryGame()
    }
    
}
