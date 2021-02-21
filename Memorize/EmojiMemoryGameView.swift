//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Bo Kane on 2/19/21.
//

import SwiftUI


struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        //created numPairs method in ViewModel; if/else control to satisfy font size requirement of lecture 2 requirement 5
        if viewModel.numPairs > 4{
            HStack {
                ForEach(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        viewModel.choose(card: card)
                        }
                    }
                }
            .foregroundColor(Color.orange)
            .padding()
            .font(.title)
        }
        else {
            HStack {
                ForEach(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        viewModel.choose(card: card)
                        }
                    }
                }
            .foregroundColor(Color.orange)
            .padding()
            .font(.largeTitle)
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
               RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
               RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
           
            } else {
               RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
        //satisy lecture 2 requirement 3
        .aspectRatio(0.66, contentMode: .fit)
    }
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
