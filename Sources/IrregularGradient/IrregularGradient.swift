//
//  IrregularGradient.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 01/12/20.
//

import SwiftUI
import Combine

public struct IrregularGradient<Background: View>: View {
    @State var blobs: [Blob]
    var background: Background
    var speed: Double
    var shouldAnimate: Bool
    
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    public init(colors: [Color],
                background: @autoclosure @escaping () -> Background,
                speed: Double = 1,
                shouldAnimate: Bool = true) {
        self._blobs = State(initialValue: colors.map({ Blob(color: $0) }))
        
        
        self.background = background()
        self.shouldAnimate = shouldAnimate
        self.speed = speed
        
        let interval = 1.0/self.speed
        self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
    }
    
    private var animation: Animation {
        .spring(response: 3.0/speed, blendDuration: 1.0/speed)
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                background
                ZStack {
                    ForEach(blobs) { blob in
                        BlobView(blob: blob,
                             geometry: geometry)
                    }
                }.compositingGroup()
                    .blur(radius: pow(min(geometry.size.width, geometry.size.height), 0.65))
            }
            .clipped()
        }.onAppear {
            update()
        }
        .onReceive(timer) { _ in
            update()
        }
        .animation(animation, value: blobs)
    }
    
    func update() {
        guard shouldAnimate else { return }
        for index in blobs.indices {
            blobs[index].position = Blob.makePosition()
            blobs[index].scale = Blob.makeScale()
            blobs[index].opacity = Blob.makeOpacity()
        }
    }
}

public extension IrregularGradient where Background == Color {
    init(colors: [Color],
         backgroundColor: Color = .clear,
         speed: Double = 1,
         shouldAnimate: Bool = true) {
        self.init(colors: colors,
                  background: backgroundColor,
                  speed: speed,
                  shouldAnimate: shouldAnimate)
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
                RoundedRectangle(cornerRadius: 30.0, style: .continuous)
                    .irregularGradient(colors: [.orange, .pink, .yellow, .orange, .pink, .yellow],
                                       backgroundColor: .orange,
                                       shouldAnimate: animate)
                Toggle("Animate", isOn: $animate)
                    .padding()
            }
            .padding(25)
        }
    }
}
