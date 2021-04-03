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
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    var seen: Set<Int>
        
    var score: Int = 0
    
    private var reward: Int = 2
    
    private var penalty: Int = 1
    
    //assignent 2 3-7
    var gameTheme: Theme<CardContent>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter {cards[$0].isFaceUp}.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    //note: this function refers to a copy of the card, not card itself
    //need to use copy to refer to array to actually modify our chosenCard
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score = score + reward
                } else {
                    if seen.contains(cards[chosenIndex].id) {
                        score = score - penalty
                    }
                    if seen.contains(cards[potentialMatchIndex].id) {
                        score = score - penalty
                    }
                    seen.insert(cards[chosenIndex].id)
                    seen.insert(cards[potentialMatchIndex].id)

                }
                self.cards[chosenIndex].isFaceUp = true
        
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
        
    init(theme: Theme<CardContent>, numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = Array<Card>()
        gameTheme = theme
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        seen = Set<Int>()
        //satisfy lecture 2 requirement 2
        cards.shuffle()
        
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var seenCount: Int = 0
        var content: CardContent
        var id: Int
    }
}
