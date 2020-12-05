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
    
    init(colors: [Color], backgroundColor: Color = .clear, animate: Binding<Bool> = .constant(true)) {
        self.colors = colors
        self.backgroundColor = backgroundColor
        self.animate = animate
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<colors.count) { index in
                    Blob(color: colors[index], animate: animate.wrappedValue, geometry: geometry)
                }
            }.blur(radius: 65)
            .clipped()
            .background(backgroundColor)
        }
    }
}

extension View {
    public func irregularGradient(colors: [Color], backgroundColor: Color = .clear, animate: Binding<Bool> = .constant(true)) -> some View {
        self.overlay(IrregularGradientView(colors: colors, backgroundColor: backgroundColor, animate: animate)).mask(self)
    }
}

struct Blob: View {
    var color: Color
    var animate: Bool
    var geometry: GeometryProxy
    
    @State var position: CGPoint = CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
    @State var scale: CGSize = CGSize(width: CGFloat.random(in: 0.5...2), height: CGFloat.random(in: 0.5...2))
    
    let timer = Timer.publish(every: Double.random(in: 2...5), on: .main, in: .common).autoconnect()
    
    var body: some View {
        Circle()
            .fill(color)
            .position(x: position.x*geometry.size.width, y: position.y*geometry.size.width)
            .scaleEffect(scale)
            .animation(.spring(response: 10, dampingFraction: 0.3))
            .onAppear(perform: update)
            .onReceive(timer) { _ in
                update()
            }
    }
    
    func update() {
        if animate {
            position = CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
            scale = CGSize(width: CGFloat.random(in: 0.5...2), height: CGFloat.random(in: 0.5...2))
        }
    }
}

struct IrregularGradient_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State var animate = false
        
        var body: some View {
            VStack {
                RoundedRectangle(cornerRadius: 40.0, style: .continuous).irregularGradient(colors: [.yellow, .pink, .orange, .pink, .orange, .yellow], backgroundColor: .orange, animate: $animate)
                Toggle(isOn: $animate, label: {
                    Text("Animate")
                }).padding()
            }.padding(25)
        }
    }
}
