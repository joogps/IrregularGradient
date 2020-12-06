//
//  IrregularGradient.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 01/12/20.
//

import SwiftUI

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

struct Blob: View {
    var color: Color
    var animate: Bool
    var speed: Double
    var geometry: GeometryProxy
    
    @State var position: CGPoint = CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
    @State var scale: CGSize = CGSize(width: CGFloat.random(in: 0...1), height: CGFloat.random(in: 0...1))
    
    let timer = Timer.publish(every: Double.random(in: 2...4), on: .main, in: .common).autoconnect()
    
    var body: some View {
        Ellipse()
            .fill(color)
            .position(position.applying(CGAffineTransform(scaleX: geometry.size.width, y: geometry.size.height)))
            .scaleEffect(scale)
            .animation(.spring(response: speed))
            .onAppear(perform: update)
            .onReceive(timer) { _ in
                update()
            }
    }
    
    func update() {
        if animate {
            position = CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
            scale = CGSize(width: CGFloat.random(in: 0...2), height: CGFloat.random(in: 0...2))
        }
    }
}

extension View {
    public func irregularGradient(colors: [Color], backgroundColor: Color = .clear, animate: Binding<Bool> = .constant(true), speed: Double = 10) -> some View {
        self.overlay(IrregularGradientView(colors: colors, backgroundColor: backgroundColor, animate: animate, speed: speed)).mask(self)
    }
}

struct IrregularGradient_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State var animate = true
        
        var body: some View {
            VStack {
                RoundedRectangle(cornerRadius: 40.0, style: .continuous).irregularGradient(colors: [.orange, .pink, .yellow, .orange, .pink, .yellow], backgroundColor: .orange, animate: $animate)
                Toggle(isOn: $animate, label: {
                    Text("Animate")
                }).padding()
            }.padding(25)
        }
    }
}
