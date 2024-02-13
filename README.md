<h1> IrregularGradient
  <picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/joogps/IrregularGradient/blob/assets/Icon-dark-small.png?raw=true">
    <img align="right" alt="Project logo" src="../assets/Icon-light-small.png" width=74px>
  </picture>
</h1>

<p>
    <img src="https://img.shields.io/badge/iOS-13.0+-blue.svg" />
    <img src="https://img.shields.io/badge/macOS-10.15+-blue.svg" />
    <img src="https://img.shields.io/badge/tvOS-13+-blue.svg" />
    <img src="https://img.shields.io/badge/watchOS-6+-blue.svg" />
    <br>
    <img src="https://img.shields.io/badge/-SwiftUI-red.svg" />
    <a href="https://twitter.com/joogps">
        <img src="https://img.shields.io/badge/Contact-@joogps-lightgrey.svg?style=social&logo=twitter" alt="Twitter: @joogps" />
    </a>
</p>

A SwiftUI library for rendering beautiful, animated  and _irregular_ gradient views.

> [!NOTE]  
> This project implements this effect using pure SwiftUI, which can be computationally expensive. If you want something more efficient, please consider switching to [FluidGradient](https://github.com/Cindori/FluidGradient).

## Installation

This repository is a Swift package, so just include it in your Xcode project and target under **File > Add package dependencies**. Then, `import IrregularGradient` to the Swift files where you'll be using it.

## Usage

You can add an irregular gradient to your app with the following modifier:

```swift
RoundedRectangle(cornerRadius: 24.0, style: .continuous)
    .irregularGradient(colors: [.orange, .pink, .yellow, .orange, .pink, .yellow], backgroundColor: .orange)
```

The other parameters go as follow:

```swift
irregularGradient(colors: [Color], background: () -> View, shouldAnimate: Binding<Bool> = .constant(true), speed: Double = 10)
```

-  `colors` specifies the colors of each blob. Order and amount matters, so the colors will be stacked in the order of the array on the Z axis. Having two entries of the same color will create two completely distinct blobs of that color.
-  `background` defines the background of your gradient. It's a closure that returns a view. Not specifying this value it will make the background clear. 
- `shouldAnimate` is a boolean that specifies whether or not the gradient blobs should move. It can be enabled and disabled dinamically, and movement will always slow down to a stop. The default value is `true`.
- `speed` accepts a Double and defines the speed of the movement — a 0.5 speed means the blobs will update every 2 seconds. The default value is 1.

You can also use the `IrregularGradient` standalone view, which exists in its own container.

## How it's done
The current implementation of this package is done through the creation of blobs (SwiftUI's [Ellipse](https://developer.apple.com/documentation/swiftui/ellipse) shape) of the specified colors that move and scale randomly in the container, and are then blurred to achieve the desired effect.

### Questions

If you have any questions or suggestions, you can create an issue or pull request on this GitHub repository or even contact me via [Twitter](https://twitter.com/joogps) or [email](mailto:joogps@gmail.com).
