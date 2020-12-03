//
//  IrregularGradient.swift
//  IrregularGradient
//
//  Created by João Gabriel Pozzobon dos Santos on 01/12/20.
//

import SwiftUI

struct IrregularGradient: View {
    
    @State var colors: [Color]
    var backgroundColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(colors, id: \.self) { color in
                    Blob(color: color, geometry: geometry)
                }
            }.blur(radius: 50)
            .clipped()
            .background(backgroundColor)
        }
    }
}

extension View {
    func irregularGradient(colors: [Color], backgroundColor: Color) -> some View {
        self.overlay(IrregularGradient(colors: colors, backgroundColor: backgroundColor)).mask(self)
    }
}

struct Blob: View {
    @State var color: Color
    @State var position: CGPoint = CGPoint(x: 0, y: 0)
    @State var scale: CGSize = CGSize(width: 1, height: 1)
    
    var geometry: GeometryProxy
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Circle()
            .fill(color)
            .scaleEffect(scale)
            .position(position)
            .opacity(0.85)
            .animation(.spring(response: 15, dampingFraction: 0.3))
            .onAppear() {
                update()
                withAnimation { update() }
            }.onReceive(timer) { input in
                withAnimation { update() }
            }
    }
    
    func update() {
        position = CGPoint(x: CGFloat.random(in: 0...geometry.size.width), y: CGFloat.random(in: 0...geometry.size.height))
        scale = CGSize(width: CGFloat.random(in: 0.25...2), height: CGFloat.random(in: 0.25...2))
    }
}

struct IrregularGradient_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Text("Irregular Gradient").multilineTextAlignment(.center).font(.system(size: 72, weight: .bold)).irregularGradient(colors: [.yellow, .red, .orange, .pink, .orange, .pink, .yellow, .red], backgroundColor: .orange)
        }
    }
}
