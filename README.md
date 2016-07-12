# Terminal

A simple Swift library to easily create command line tools
```swift
import Terminal

Tool.run(
    Block(name:"hello", description:"hello") {
        print("Hello")
    }
)
```
```bash
~ > ./say hello
Hello
```

## Usage
#### Command
```swift
struct Hello : Command {

    let name = "hello"
    let description = "Say hello"

    func run(with arguments:Arguments) {
        print("Hello")
    }
}
```

#### Modes
TODO
#### Options
TODO
