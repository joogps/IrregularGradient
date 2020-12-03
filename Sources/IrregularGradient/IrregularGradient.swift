//
//  IrregularGradient.swift
//  IrregularGradient
//
//  Created by João Gabriel Pozzobon dos Santos on 01/12/20.
//

import SwiftUI

struct IrregularGradient: View {
    @State var colors: [Color]
    var backgroundColor: Color = .clear
    
    var animate: Binding<Bool> = .constant(true)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(colors, id: \.self) { color in
                    Blob(color: color, animate: animate.wrappedValue, geometry: geometry)
                }
            }.blur(radius: 75)
            .clipped()
            .background(backgroundColor)
        }
    }
}

extension View {
    func irregularGradient(colors: [Color], backgroundColor: Color = .clear, animate: Binding<Bool> = .constant(true)) -> some View {
        self.overlay(IrregularGradient(colors: colors, backgroundColor: backgroundColor, animate: animate)).mask(self)
    }
}

struct Blob: View {
    var color: Color
    var animate: Bool
    var geometry: GeometryProxy
    
    @State var position: CGPoint = CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
    @State var scale: CGSize = CGSize(width: CGFloat.random(in: 0.25...1.75), height: CGFloat.random(in: 0.25...1.75))
    
    let timer = Timer.publish(every: Double.random(in: 2...5), on: .main, in: .common).autoconnect()
    
    var body: some View {
        Circle()
            .fill(color)
            .position(x: position.x*geometry.size.width, y: position.y*geometry.size.width)
            .scaleEffect(scale)
            .opacity(0.75)
            .animation(.spring(response: 10, dampingFraction: 0.3))
            .onAppear(perform: update)
            .onReceive(timer) { _ in
                update()
            }
    }
    
    func update() {
        if animate {
            position = CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
            scale = CGSize(width: CGFloat.random(in: 0.25...1.75), height: CGFloat.random(in: 0.25...1.75))
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
                RoundedRectangle(cornerRadius: 40.0, style: .continuous).irregularGradient(colors: [.yellow, .orange, .red, .pink, .yellow, .orange, .red, .pink], backgroundColor: .orange, animate: $animate)
                Toggle(isOn: $animate, label: {
                    Text("Animate")
                }).padding()
            }.padding(25)
        }
    }
}
