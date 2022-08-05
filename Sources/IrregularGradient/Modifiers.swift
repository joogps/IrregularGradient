//
//  Modifiers.swift
//  
//
//  Created by Julian Schiavo on 5/4/2021.
//

import SwiftUI

extension View {
    /// Replace view's contents with a gradient.
    ///
    /// - Parameters:
    ///   - colors: The colors of the blobs in the gradient.
    ///   - background: The background view of the gradient.
    ///   - speed: The speed at which the blobs move, if they're moving.
    ///   - animate: Whether or not the blobs should move.
    public func irregularGradient<Background: View>(colors: [Color],
                                                    background: @autoclosure @escaping () -> Background,
                                                    animate: Bool = true,
                                                    speed: Double = 1) -> some View {
        self
            .overlay(IrregularGradient(colors: colors,
                                       background: background(),
                                       speed: speed,
                                       animate: animate))
            .mask(self)
    }
    
    @available(*, deprecated, message: "Replace \"backgroundColor\" with \"background\"")
    public func irregularGradient(colors: [Color],
                                  backgroundColor: Color = .clear,
                                  animate: Bool = true,
                                  speed: Double = 1) -> some View {
        self
            .irregularGradient(colors: colors,
                               background: backgroundColor,
                               animate: animate,
                               speed: speed)
    }
}

extension Shape {
    /// Fill a shape with a gradient.
    ///
    /// - Parameters:
    ///   - colors: The colors of the blobs in the gradient. 
    ///   - background: The background view of the gradient.
    ///   - speed: The speed at which the blobs move, if they're moving.
    ///   - animate: Whether or not the blobs should move.
    public func irregularGradient<Background: View>(colors: [Color],
                                                    background: @autoclosure @escaping () -> Background,
                                                    animate: Bool = true,
                                                    speed: Double = 1) -> some View {
        self
            .overlay(IrregularGradient(colors: colors,
                                       background: background(),
                                       speed: speed,
                                       animate: animate))
            .clipShape(self)
    }
}
