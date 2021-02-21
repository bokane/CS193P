//
//  MemoryGame.swift
//  Memorize
//
//  Created by Bo Kane on 2/20/21.
//

import Foundation
// this file is our "model" per the MVVM framework
//models might not be structs, could be SQL database, network thing, etc.
//CardContent is a "don't care" type - we'll initialize as a string later
struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    //note: this function refers to a copy of the card, not card itself
    //need to use copy to refer to array to actually modify our chosenCard
    mutating func choose(card: Card){
        print("card chosen: \(card)")
        let chosenIndex: Int = self.index(of: card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<self.cards.count {
            if self.cards[index].id == card.id {
                return index
            }
        }
        return 0 // TODO: bogus!
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        //satisfy lecture 2 requirement 2
        cards.shuffle()
        
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
