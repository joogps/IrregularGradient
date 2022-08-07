//
//  IrregularGradient.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 01/12/20.
//

import SwiftUI
import Combine

/// A view that displays an irregular gradient.
public struct IrregularGradient<Background: View>: View {
    @State var blobs: [Blob]
    var background: Background
    var speed: Double
    var animate: Bool
    
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    /// - Parameters:
    ///   - colors: The colors of the blobs in the gradient.
    ///   - background: The background view of the gradient.
    ///   - speed: The speed at which the blobs move, if they're moving.
    ///   - animate: Whether or not the blobs should move.
    public init(colors: [Color],
                background: @autoclosure @escaping () -> Background,
                speed: Double = 1,
                animate: Bool = true) {
        self._blobs = State(initialValue: colors.map({ Blob(color: $0) }))
        
        self.background = background()
        self.animate = animate
        self.speed = speed
        
        assert(self.speed > 0, "Speed should be greater than zero.")
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
        }.onAppear(perform: update)
        .onReceive(timer) { _ in
            update()
        }
        .animation(animation, value: blobs)
    }
    
    func update() {
        guard animate else { return }
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
         animate: Bool = true) {
        self.init(colors: colors,
                  background: backgroundColor,
                  speed: speed,
                  animate: animate)
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
                                       background: Color.orange,
                                       animate: animate)
                Toggle("Animate", isOn: $animate)
                    .padding()
            }
            .padding(25)
        }
    }
}
