# CS193P
Hacking my way through [CS193P](https://cs193p.sites.stanford.edu/) - Developing Applications for iOS using SwiftUI. 

# Lecture Notes
I've found even if I don't always refer to them after the fact (acknowledging I probably should...) taking notes during lecture videos increases my focus and retention. 

##LECTURE 3 NOTES
protocols are stripped down versions of structs/classes
protocols can have funcs/vars but no implementation or storage
another type can implement a given protocol
**EXAMPLE:**
  protocol Moveable {
      func move(by: Int)
      var hasMoved: Bool { get }
      var distanceFromStart: Int { get set }
  }
  struct PortableThing: Moveable {
  //must implement move, hasmoved, distancefromstart
  }

A single type can implement multiple protocols, as long as it implements requirements from the superset of protocols it purports to adhere to. Note, protocols are "constrains-gains" implementations. We can add implementations to a protocol using an **extension**:

**EXAMPLE:**
extension Vehicle {
	func registerWithDMV() { *implementation here* }
}

Extensions can also provide "default implementations", e.g.
**EXAMPLE**
```swift  
  protocol Moveable {
      func move(by: Int)
      var hasMoved: Bool { get }
      var distanceFromStart: Int { get set }
  }
  extension Moveable {
  	  var hasMoved: Bool { return distancefromStart > 0 }
  }
```

  Why do we have protocols? Protocols are methods for types to say what they are capable of. Also allows us to demand certain properties of objects. In the context of functional programming, protocols formalize data structures in our app function. It's a higher level of encapsulation of OOP.

**Generics and Protocols**
Below is an example where we use a protocol to extend Array such that there is a greatest element. Element is typically a throwaway, but in this case the protocol extension guarantees we can find a greatest element, *even though element is a Generic*.

```swift
protocol Greatness {
	func isGreaterThan(other: Self) -> Bool //note: capital-S 'Self', Swift idiosyncrasy
}

extension Array where Element: Greatness {
	var greatest: Element {
		//loop through all elements
		//which we know must implement 

	}

}
```



## LECTURE 2 NOTES
 lecture 2 part 1 - intro to MVVM paradigm
 MVVM == Model-View-ViewModel
 model = backend
  UI independent - encapsulates data + logic of application
  e.g. in this case, cards + logic of game (points, matching, mismatching)
 view is UI
  view reflects the model
  data flows from model into view as read-only; view reflects state of game from model
  view is 'stateless' - at any time you make it look like model, this also means view is 'reactive' - it's reacting to changes in the model
  code from lecture one was effectively designing a basic view for the game; there were no functions or logic (isFaceUp is close, but needs to be defined by a Model)
  note, lecture 1 code is localized - UI lives in one place!
  ViewModel - binds view to model. VM 'interprets' model into simpler data structures that it passes to the View
  VM notices changes in model - might convert data, then publishes changes. View **observes** publications, then pulls necessary data and rebuilds
  VM processes (uses') **Intent**, e.g. user wants to choose a card. View will call an intent function in the VM, which could potentially change the Model/game logic/trigger a new state in the model  lecture 2 part 2 - intro to Swift Types
  six types: struct, class, protocol, enum, generics, functions
  struct and class have similar syntax
  both can have stored vars (like isFaceUp), computed vars (like body: some View {}), and constant 'let's, like vars but immutable
  can have functions too
  also have initializers - functions that are called when we create a struct/class, e.g. create a MemoryGame struct initialized to a certain number of pairs of cards
  difference: struct is a value type; class is a reference type
  reference types are stored in memory
  value types are copied
  structs support functional programming while classes support OOP
  structs have no inheritance, class have single inheritance
  structs' mutability must be stated; class's are always mutable
  structs are our GO TO data structure; class's are for certain cases
      --> ViewModel is always a class (because it must be shared, so pointer makes sense) generics - array - list of things where we don't care what type the 'things' are
 the function to append an item to generics contains Element, which is a "don't care type"  functions are types too!
  (Int, Int) -> Bool <-- this is a type! as if the entire string is "Int" or "Text"
  (Double) -> Void
  example:
  var operation: (Double) -> Double
  func square(operand: Double) -> Double {
        return operand * operand
  }
  let result1 = operation(4) <-- returns 16
  so we can say operation = square // assigns square function to operation var

##LECTURE 1 NOTES
declarations with :'s are variable names
some basically means the View can have any type
Views must always have a body variable

