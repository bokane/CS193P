//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Bo Kane on 2/20/21.
//

import SwiftUI

//private(set) is like a closed but glass door
//only EmojiMemoryGame can set the model, but Views can still read

class EmojiMemoryGame {
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    //static makes a function on the type, rather than the instance
    static func createMemoryGame() -> MemoryGame<String>{
        let emojis: Array<String> = ["🎃","👻", "🕷", "👺", "🕸"]
        //satisfy lecture 2 requirement 4
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2..<6)) { pairIndex in
            return emojis[pairIndex]
        }
    }
    //
    //MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    //supports control statement in ContentView.swift for lecture 2 requirement 5
    var numPairs: Int{
        return model.cards.count / 2
    }
    
    //MARK: - Intents(s)
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
        
}


