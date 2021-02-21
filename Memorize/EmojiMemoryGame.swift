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
        // parameterize game size (min to max pairs)
        let maxPairs: Int = 5
        let minPairs: Int = 2
        var emojiStart: Array<String> = ["🎃","👻", "🕷", "👺", "🕸", "👹", "😈", "⻤", "🍭", "🍫", "🍬", "🦹🏻‍♂️"]
        emojiStart.shuffle()
        var emojiFinal: Array<String> = Array<String>()
        
        //lecture 2 extra credit solution (randomly select subset of emojis from superset of 12)
        //shuffle emojistart (one-liner above) then pop and append element to emojiFinal
        var emojiIndex: Int = 0
        while emojiIndex < maxPairs {
            emojiFinal.append(emojiStart.popLast()!)
            emojiIndex += 1
            }

        //satisfy lecture 2 requirement 4 (random number of pairs)
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: minPairs..<maxPairs+1)) { pairIndex in
            return emojiStart[pairIndex]
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



