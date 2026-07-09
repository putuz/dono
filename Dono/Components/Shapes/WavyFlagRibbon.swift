//
//  WavyFlagRibbon.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

// MARK:  WavyFlagRibbon
struct WavyFlagRibbon: Shape {
    /// Number of full waves across the width. 1.0 = one gentle S-curve.
    var waveCount: Double = 1
    /// How tall the wave's ripple is, as a fraction of the shape's height.
    var amplitude: CGFloat = 0.20
    /// Thickness of the ribbon band, as a fraction of the shape's height.
    var thickness: CGFloat = 0.5
 
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        let midY = h * 0.3
        let amp = h * amplitude
        let thick = h * thickness
 
        // Sample the wave at several points and connect them with
        // addCurve for a smooth (non-jagged) result.
        let sampleCount = 24
        func waveY(at t: Double) -> CGFloat {
            // t goes 0...1 across the width
            midY + amp * CGFloat(sin(t * .pi * 2 * waveCount))
        }
 
        var topPoints: [CGPoint] = []
        for i in 0...sampleCount {
            let t = Double(i) / Double(sampleCount)
            let x = CGFloat(t) * w
            topPoints.append(CGPoint(x: x, y: waveY(at: t) - thick / 1.5))
        }
 
        var path = Path()
        path.move(to: topPoints[0])
        for point in topPoints.dropFirst() {
            path.addLine(to: point) // fine-grained samples read smoothly as a curve
        }
 
        // Right edge: straight down by the ribbon thickness
        path.addLine(to: CGPoint(x: w, y: waveY(at: 1) + thick / 2))
 
        // Bottom edge: same wave, shifted down, traced right -> left
        for i in stride(from: sampleCount, through: 0, by: -1) {
            let t = Double(i) / Double(sampleCount)
            let x = CGFloat(t) * w
            path.addLine(to: CGPoint(x: x, y: waveY(at: t) + thick / 0.7))
        }
 
        path.closeSubpath()
        return path
    }
}
