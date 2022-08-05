//
//  Blob.swift
//  
//
//  Created by Julian Schiavo on 5/4/2021.
//

import Combine
import SwiftUI

struct Blob: Identifiable, Equatable {
    let id = UUID()
    let color: Color
    
    var position: CGPoint = makePosition()
    var scale: CGSize = makeScale()
    var opacity: CGFloat = makeOpacity()
    
    static func makePosition() -> CGPoint {
        return CGPoint(x: CGFloat.random(in: 0...1),
                       y: CGFloat.random(in: 0...1))
    }
    
    static func makeScale() -> CGSize {
        return CGSize(width: CGFloat.random(in: 0.25...1),
                      height: CGFloat.random(in: 0.25...1))
    }
    
    static func makeOpacity() -> CGFloat {
        return CGFloat.random(in: 0.75...1)
    }
}

struct BlobView: View {
    var blob: Blob
    var geometry: GeometryProxy
    
    private var transformedPosition: CGPoint {
        let transform = CGAffineTransform(scaleX: geometry.size.width, y: geometry.size.height)
        return blob.position.applying(transform)
    }
    
    var body: some View {
        Ellipse()
            .foregroundColor(blob.color)
            .position(transformedPosition)
            .scaleEffect(blob.scale)
            .opacity(blob.opacity)
    }
}
