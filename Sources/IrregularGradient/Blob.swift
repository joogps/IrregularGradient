//
//  Blob.swift
//  
//
//  Created by Julian Schiavo on 5/4/2021.
//

import Combine
import SwiftUI

struct Blob: View {
    var color: Color
    var shouldAnimate: Bool
    var speed: Double
    var geometry: GeometryProxy
    
    @State private var position: CGPoint = CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
    @State private var scale: CGSize = CGSize(width: CGFloat.random(in: 0...1), height: CGFloat.random(in: 0...1))
    
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    init(color: Color, animate: Bool, speed: Double, geometry: GeometryProxy) {
        self.color = color
        self.shouldAnimate = animate
        self.speed = speed
        self.geometry = geometry
        
        let interval = speed / Double.random(in: 2...5)
        self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
    }
    
    private var animation: Animation {
        .spring(response: speed * Double.random(in: 0.8...1.25))
    }
    
    private var transformedPosition: CGPoint {
        let transform = CGAffineTransform(scaleX: geometry.size.width, y: geometry.size.height)
        return position.applying(transform)
    }
    
    var body: some View {
        Ellipse()
            .fill(color)
            .position(transformedPosition)
            .scaleEffect(scale)
            .animation(animation)
            .onAppear(perform: update)
            .onReceive(timer) { _ in
                update()
            }
    }
    
    private func update() {
        guard shouldAnimate else { return }
        position = CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
        scale = CGSize(width: CGFloat.random(in: 0...2), height: CGFloat.random(in: 0...2))
    }
}
