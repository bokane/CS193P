//
//  ContentView.swift
//  Memorize
//
//  Created by Bo Kane on 2/19/21.
//

import SwiftUI

// lecture 2 notes
// lecture 2 part 1 - intro to MVVM paradigm
// MVVM == Model-View-ViewModel
// model = backend
//  UI independent - encapsulates data + logic of application
//  e.g. in this case, cards + logic of game (points, matching, mismatching)
// view is UI
//  view reflects the model
//  data flows from model into view as read-only; view reflects state of game from model
//  view is 'stateless' - at any time you make it look like model, this also means view is 'reactive' - it's reacting to changes in the model
//  code from lecture one was effectively designing a basic view for the game; there were no functions or logic (isFaceUp is close, but needs to be defined by a Model)
//  note, lecture 1 code is localized - UI lives in one place!
//  ViewModel - binds view to model. VM 'interprets' model into simpler data structures that it passes to the View
//  VM notices changes in model - might convert data, then publishes changes. View **observes** publications, then pulls necessary data and rebuilds
//  VM processes (uses') **Intent**, e.g. user wants to choose a card. View will call an intent function in the VM, which could potentially change the Model/game logic/trigger a new state in the model

//  lecture 2 part 2 - intro to Swift Types
//  six types: struct, class, protocol, enum, generics, functions
//  struct and class have similar syntax
//  both can have stored vars (like isFaceUp), computed vars (like body: some View {}), and constant 'let's, like vars but immutable
//  can have functions too
//  also have initializers - functions that are called when we create a struct/class, e.g. create a MemoryGame struct initialized to a certain number of pairs of cards
//  difference: struct is a value type; class is a reference type
//  reference types are stored in memory
//  value types are copied
//  structs support functional programming while classes support OOP
//  structs have no inheritance, class have single inheritance
//  structs' mutability must be stated; class's are always mutable
//  structs are our GO TO data structure; class's are for certain cases
//      --> ViewModel is always a class (because it must be shared, so pointer makes sense)

// generics - array - list of things where we don't care what type the 'things' are
// the function to append an item to generics contains Element, which is a "don't care type"

//  functions are types too!
//  (Int, Int) -> Bool <-- this is a type! as if the entire string is "Int" or "Text"
//  (Double) -> Void
//  example:
//  var operation: (Double) -> Double
//  func square(operand: Double) -> Double {
//        return operand * operand
//  }
//  let result1 = operation(4) <-- returns 16
//  so we can say operation = square // assigns square function to operation var



//lecture 1 notes
//declarations with :'s are variable names
//some basically means the View can have any type
//Views must always have a body variable

let colors: [Color] =
    [.red, .orange, .yellow, .green, .blue, .purple]

struct ContentView: View {
    
    var viewModel: EmojiMemoryGame
    
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
        ContentView(viewModel: EmojiMemoryGame())
    }
}
