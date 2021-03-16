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
        VStack{
            HStack{
                //lecture 4 requirement 6
                Button("New Game"){
                    viewModel.newGame()
                }
                .contentShape(Rectangle())
                
                Text(viewModel.gameTheme.themeName)
            }
            .padding(5)
            HStack{
                Text("Score:")
            }
            
            Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        viewModel.choose(card: card)
                    }.padding(4)
            }
            .foregroundColor(Color.orange)
                .padding()

        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
               RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
               RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
               Text(card.content)
           
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    //MARK: Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    let fontScaleFactor: CGFloat = 0.75
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height)*fontScaleFactor
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
