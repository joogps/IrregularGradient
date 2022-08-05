<h1> IrregularGradient
  <picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/joogps/IrregularGradient/blob/assets/Icon-dark-small.png?raw=true">
    <img align="right" alt="Project logo" src="../assets/Icon-light-small.png" width=74px>
  </picture>
</h1>

<p>
    <img src="https://img.shields.io/badge/iOS-13.0+-blue.svg" />
    <img src="https://img.shields.io/badge/-SwiftUI-red.svg" />
    <a href="https://twitter.com/joogps">
        <img src="https://img.shields.io/badge/Contact-@joogps-lightgrey.svg?style=social&logo=twitter" alt="Twitter: @joogps" />
    </a>
</p>

A SwiftUI library for rendering beautiful, animated  and _irregular_ gradient views.

## Installation

Since this is a Swift package, it can be installed via the Swift Package Manager. To do this, all you gotta do is open your Xcode project, add a new depedency under **File > Add Packages**, search for this repo and install it. Then, it's all done!

## Usage

To add an irregular gradient to your app all you gotta do is add `import IrregularGradient` to the file you're using and then use the `irregularGradient(colors: [Color], background: () -> View, shouldAnimate: Binding<Bool> = .constant(true), speed: Double = 10)` modifier. 

- The first, required, argument `colors` specifies the colors of each blob. Order and amount matters, so the colors will be stacked in the order of the array on the Z axis. Having two entries of the same color will create two completely distinct blobs of that color.
- The `background` argument defines the background of your gradient. It's a closure that returns a view, but can also just be a simple color if you use `backgroundColor` instead. Not specifying this value it will make the background clear. 
- `shouldAnimate` is a boolean that specifies whether or not the gradient blobs should move. It can be enabled and disabled dinamically, and movement will always slow down to a stop. The default value is `true`.
- The `speed` argument accepts a Double and defines the speed of the movement – a 0.5 speed means the blobs will update every 2 seconds. The default value is 1.

```swift
RoundedRectangle(cornerRadius: 30.0, style: .continuous)
    .irregularGradient(colors: [.orange, .pink, .yellow, .orange, .pink, .yellow], backgroundColor: .orange)
```

You can also use the `IrregularGradient` standalone view, which exists in its own container.

## Implementation
The current implementation of this package is done through the creation of blobs (SwiftUI's [Ellipse](https://developer.apple.com/documentation/swiftui/ellipse) shape) of the specified colors that move and scale randomly in the container, and are then blurred to achieve the desired effect.

### Questions

If you have any questions or suggestions, you can create an issue or pull request on this GitHub repository or even contact me via [Twitter](https://twitter.com/joogps) or [email](mailto:joogps@gmail.com).
