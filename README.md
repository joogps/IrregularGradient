<img src="../assets/title.gif" height=80 alt="IrregularGradient"/>
<p>
    <img src="https://img.shields.io/badge/iOS-13.0+-blue.svg" />
    <img src="https://img.shields.io/badge/-SwiftUI-red.svg" />
    <a href="https://twitter.com/joogps">
        <img src="https://img.shields.io/badge/Contact-@joogps-lightgrey.svg?style=social&logo=twitter" alt="Twitter: @joogps" />
    </a>
</p>

A SwiftUI library for rendering beautiful, animated  and _irregular_ gradient views.

## Installation

Since this is a Swift package, it can be installed via the Swift Package Manager. To do this, all you gotta do is open your Xcode project, add a new depedency under **File > Swift Package Manager**, search for this repo and install it. Then, it's all done!

## Usage

To use this library all you gotta do is add `import IrregularGradient` to the file you're using and then add an irregular gradient to any view you want with the `irregularGradient(colors: [Color], backgroundColor: Color = .clear, animate: Binding<Bool> = .constant(true), speed: Double = 10)` modifier. 

- The first argument (and the only required one) `colors` specifies the colors of each gradient blob. Order and quantity matters, so the last color you add will always stay on top, and having two blues will create two separate blue blobs.
- The `backgroundColor` argument defines the background color of your gradient, which will occupy the full container (not specifying it will make it transparent). 
- `animate` is a boolean binding that specifies wheter or not the gradient should perform its natural movement. It can be enabled and disabled dinamically, but movement will never stop abruptly.
- The `speed` argument accepts a Double and defines how fast the blobs move and update.

```swift
RoundedRectangle(cornerRadius: 30.0, style: .continuous)
    .irregularGradient(colors: [.orange, .pink, .yellow, .orange, .pink, .yellow], backgroundColor: .orange)
```

You can also use the `IrregularGradientView` which works the exact same way except for the fact that instead of filling an already existing view, it exists in its own container.

### Questions

If you have any questions or suggestions, you can create an issue on this repo or even contact me via Twitter or email!
