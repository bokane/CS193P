# Lecture Notes
I've found even if I don't always refer to them after the fact (acknowledging I probably should...) taking notes during lecture videos increases my focus and retention. 


## Lecture 5 Notes

**Note to self**: Cmd+Shift+O in Xcode to quickly move between files significantly improved navigation. Should spend time learning other keyboard shortcuts, and generally incorporate this pattern anytime you work with new software. Don't let your use patterns remain complacent!

### Access Control
First use of access control was ```private``` in our ```EmojiMemoryGame``` class. ```private(set)``` is a read-only access control, allowing other parts of the program to read but not define a variable.

In case of the ```card``` struct, we don't need to make it private because the only time a ```card``` is accessed is via the ```cards``` array, which we've made ```private(set)```.

### ViewBuilder
```@ViewBuilder``` is a mechanism to support listed oriented syntax to create Views. This keyword can be applied to any function that returns something conforming to View. If between 2 and 10 Views, will turn into a ```TupleView```. 

**EXAMPLE** 
If we wanted to roll up the creation of a front card View in Memorize, we could do the following:
```swift
@ViewBuilder
func front(of card: Card) -> some View {
  RoundedRectangle(cornerRadius: 10)
  RoundedRectangle(cornerRadius: 10).stroke()
  Text(card.content)
}
```

The ViewBuilder example above returns the following type: ```TupleView<RoundedRectangle, RoundedRectangle, Text>```. 

### Shapes
Shape is a protocol that inherits from Views -> all Shapes are also Views. We've used ```RoundedRectangle``` but there are plenty of others. By default, Shapes fill themselves with the default foreground color. But we can call ```.stroke()``` or ```.fill()``` with arguments to edit this, e.g. a standard Color. Shape is implemented with a "don't care" generic, roughly along the lines of the below:
```swift
func fill<S>(_ whatToFillWith: S) -> View where S: ShapeStyle
```
This is an example of a generic subject to a protocol restriction, so the generic can be any type that implements [```ShapeStyle```](https://developer.apple.com/documentation/swiftui/shapestyle). Based on the docs, these can include Color, ImagePaint, AngularGradient, LinearGradient, etc.

To create our own Shape, we are required to implement the following function:

```swift
func path(in rect: CGRect) -> Path {
  return a Path
}
```
Paths are bezier curves, lines, arcs, etc. used in constructing a custom Shape. 

### Animation
Animation is important in a mobile user interface. You could for example animate by animating a Shape, but you can also animate Views generally via their ```ViewModifiers```. 

```ViewModifiers``` are functions that modify our Views. Most of them are implemented using the  

A glimpse at the protocol for such a function:
```swift
protocol ViewModifier {
  associatedtype Content //this is effectively a protocol's version of a generic / "don't care"
  func body(content: Content) -> some View {
    return "some View that represents a modification of *content*"
  }
}
```
when we call a ```modifier``` on a View, the ```content``` passed to our ```ViewModifier``` function *is* that View. Example: if we wanted a modifier to take some View, then 'card-ify' that view onto a card like in Memorize, we'd make a ```ViewModifier``` function. 

**EXAMPLE:**
```swift
Text("👻").modifier(Cardify(isFaceUp: true) // eventually, this will be .cardify(isFaceUp: true)

struct Cardify: ViewModifier {
  var isFaceUp: Bool
  func body(content: Content) -> some View {
    ZStack {
      if isFaceUp {
        RoundedRectangle(cornerRadius: 10).fill(Color.white)
        RoundedRectangle(cornerRadius: 10).strok()
        content
      }
      else {
        RoundedRectangle(cornerRadius: 10)
      }
    }
  }
}
```

To simplify further, we create an extension to View as follows:
```swift
extension View {
  func cardify(isFaceUp: Bool) -> some View {
    return self.modifier(Cardify(isFaceUp))
  }
}
``` 




## Lecture 4 Notes
Starting off continuing the Memorize build, namely creating a grid as opposed to just rows or just columns. 

Enums are a type of data structure where the value takes discrete states. 

**EXAMPLE:**
```swift
enum FastFoodMenuItem {
    case hamburger
    case fries
    case drink
    case cookie
}
```
```Enum```s are copied and passed around - like structs, unlike classes. Discrete values in ```enum```s can have its own associated data:

**EXAMPLE:**
```swift
enum FastFoodMenuItem {
    case hamburger(numberofPatties: Int)
    case fries(size: FryOrderSize)
    case drink(String, ounces: Int) // unnamed string could be the brand, e.g. Coke
    case cookie
}
```

**EXAMPLE:**
Setting the value of an ```enum```:
```swift
  let menuItem = FastFoodMenuItem.hamburger(patties: 2)
  var otherItem: FastFoodMeniItem = .cookie 
```

Checking the state of an ```enum```:
```swift
var menuItem = FastFoodMenuItem.hamburger(patties: 2)
switch meniItem {
  case FastFoodMenuItem.hamburger: print("burger") // can break out of the switch statement
  case FastFoodMenuItem.fries: print("fries")
  case FastFoodMenuItem..drink: print("drink")
  case FastFoodMenuItem.cookie: print("cookie")
}
```
Note: in the above example, we have to case every possible item. You can use ```default``` for cases if too many, or we only care about a few:
```swift
var menuItem = FastFoodMenuItem.cookie
switch meniItem {
  case .hamburger: break
  case .fries: print("fries")
  default: print("other")
}
```

You can also declare functions to retrieve info about an ```enum```.
**EXAMPLE:**
```swift
enum FastFoodMenuItem {

  func isIncludedInSpecialOrder(number: Int) -> Bool {
    switch self {
      case .hamburger(let pattyCount): return pattyCount == number
      case .fries, .cookie: return true
      case .drink(_, let ounces): return ounces == 16
    }

  }

}
```

The most important ```enum```: ```Optional```.

**Example:**
```swift
enum Optional<T> { //generic type, like Array<Element> or MemoryGame<CardContent>
  case none
  case some(T)

}
``` 
Note the ```Optional``` can onlyhave two values: ```is set``` (some) or ```not set``` (none). In the ```is set``` case, associated data can tag along (of dont care type ```T```). We use  ```Optional``` any time a variable is unspecified or undetermined e.g. the bogus ```return 0``` from our ```firstIndex(matchin:)``` function. Below are some examples of how ```Optional```s are called.
**EXAMPLE:**
```swift
  var hello: String?              var hello: Optional<String> = .none
  var hello: String? = "hello"    var hello: Optional<String> = .some("hello")
  var hello: String? = nil        var hello: Optional<String> = .none
```

```Optionals``` always start with an implicit ```nil```.


## LECTURE 3 NOTES
protocols are stripped down versions of structs/classes
protocols can have funcs/vars but no implementation or storage
another type can implement a given protocol
**EXAMPLE:**
```swift
  protocol Moveable {
      func move(by: Int)
      var hasMoved: Bool { get }
      var distanceFromStart: Int { get set }
  }
  struct PortableThing: Moveable {
  //must implement move, hasmoved, distancefromstart
  }
```

A single type can implement multiple protocols, as long as it implements requirements from the superset of protocols it purports to adhere to. Note, protocols are "constrains-gains" implementations. We can add implementations to a protocol using an **extension**:

**EXAMPLE:**
```swift
extension Vehicle {
	func registerWithDMV() { *implementation here* }
}
```

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

### Generics and Protocols
Below is an example where we use a protocol to extend Array such that there is a greatest element. Element is typically a throwaway, but in this case the protocol extension guarantees we can find a greatest element, *even though element is a Generic*.

```swift
protocol Greatness {
	func isGreaterThan(other: Self) -> Bool //note: capital-S 'Self', Swift idiosyncrasy
}

extension Array where Element: Greatness {
	var greatest: Element {
		//we know this array must implement Greatness protocol defined above
		//so we figure out which element is greatest by iterating on all elements and call isGreaterThan on each
		//return the greatest by calling isGreaterThan on each Element pairwise
	}

}
```
### Layouts
How do we apportion on-screen real estate to various Views (HStack, ZStack etc)? Answer:

1. 'container' views offer space to subset views
2. views choose what size they should be
3. Container views then position subset views inside of themselves.

Modifiers like *.padding* contain the view they modify, but others do layout.

#### The "Stacks"
HStack and VStack divide space equally, and offer that space to 'least flexible' views first. Images are relatively inflexible, less inflexible is text because it sizes itself to show text it contains, and RoundedRectangle very flexible because it uses any space offered. 

After the spacing bargaining, the stacks size themselves accordingly.

Helpful views, sounds like we'll need for lect 4 homework:
```swift
 Spacer(minLength: CGFloat) //takes all the space offered to it but draws nothing, thereby creating space in the UI
 Divider() // draws vertical dividing line, takes min space needed to fit line
``` 

Note stacks' space offering can be overridden as follows. The code below prioritizes showing "Important" text, then the image, then "Unimportant" gets any residual space.
```swift
HStack {
	Text("Important").layoutPriority(100) // any floating point number is OK
	Image(systemName: "arrow.up") // default layout priority is 0
	Text("Unimportant")
}
```

**Alignment**: VStack and HStack have argument alignment to distribute columns or rows respectively. 

### GeometryReader
You can wrap *GeometryReader* around Views that would normally appear in body:
```swift
var body: View {
	GeometryReader { geometry in //not showing content: parameter label note 
	...
	}
}

struct GeometryProxy {
	var size: CGSize
	func frame(in: CoordinateSpace) -> CGRect
	var safeAreaInsets: EdgeInsets 
}

```
In the example above, ```size``` var is the space being offered by our container view.
 

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
```swift
  var operation: (Double) -> Double
  func square(operand: Double) -> Double {
        return operand * operand
  }
  let result1 = operation(4) <-- returns 16
```
  so we can say operation = square // assigns square function to operation var

## LECTURE 1 NOTES
declarations with :'s are variable names
some basically means the View can have any type
Views must always have a body variable

