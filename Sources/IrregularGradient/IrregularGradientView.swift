//
//  IrregularGradientView.swift
//  
//
//  Created by Julian Schiavo on 5/4/2021.
//

import SwiftUI

@available(*, deprecated, renamed: "IrregularGradient")
public struct IrregularGradientView: View {
    var colors: [Color]
    var backgroundColor: Color
    var animate: Bool
    var speed: Double
    
    public init(colors: [Color],
                backgroundColor: Color = .clear,
                animate: Binding<Bool> = .constant(true),
                speed: Double = 1) {
        self.colors = colors
        self.backgroundColor = backgroundColor
        self.animate = animate.wrappedValue
        self.speed = speed
    }
    
    public var body: some View {
        IrregularGradient(colors: colors, background: backgroundColor, speed: speed, shouldAnimate: animate)
    }
}
