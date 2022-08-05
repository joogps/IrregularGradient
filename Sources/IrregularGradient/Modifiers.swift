//
//  Modifiers.swift
//  
//
//  Created by Julian Schiavo on 5/4/2021.
//

import SwiftUI

extension View {
    public func irregularGradient<Background: View>(colors: [Color],
                                                    background: @autoclosure @escaping () -> Background,
                                                    shouldAnimate: Bool = true,
                                                    speed: Double = 1) -> some View {
        self
            .overlay(IrregularGradient(colors: colors,
                                       background: background(),
                                       speed: speed,
                                       shouldAnimate: shouldAnimate))
            .mask(self)
    }
    
    public func irregularGradient(colors: [Color],
                                  backgroundColor: Color = .clear,
                                  shouldAnimate: Bool = true,
                                  speed: Double = 1) -> some View {
        self
            .irregularGradient(colors: colors,
                               background: backgroundColor,
                               shouldAnimate: shouldAnimate,
                               speed: speed)
    }
}
