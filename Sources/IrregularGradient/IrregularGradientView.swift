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
    var animate: Binding<Bool>
    var speed: Double
    
    public init(colors: [Color], backgroundColor: Color = .clear, animate: Binding<Bool> = .constant(true), speed: Double = 10) {
        self.colors = colors
        self.backgroundColor = backgroundColor
        self.animate = animate
        self.speed = speed
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundColor
                ZStack {
                    ForEach(0..<colors.count) { index in
                        Blob(color: colors[index], animate: animate.wrappedValue, speed: speed, geometry: geometry)
                    }
                }.blur(radius: pow(min(geometry.size.width, geometry.size.height), 0.75))
            }.clipped()
        }
    }
}
