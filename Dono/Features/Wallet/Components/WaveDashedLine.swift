//
//  WaveDashedLine.swift
//  Dono
//
//  Created by Bahtiar on 13/07/26.
//

import SwiftUI

// Bentuk garis bergelombang untuk WalletEmptyDivider
struct WaveDashedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let midY = rect.midY
        let waveWidth: CGFloat = 30
        let amplitude: CGFloat = 8
 
        path.move(to: CGPoint(x: 0, y: midY))
 
        var x: CGFloat = 0
        var goingUp = true
        while x < rect.width {
            let nextX = min(x + waveWidth, rect.width)
            path.addQuadCurve(
                to: CGPoint(x: nextX, y: midY),
                control: CGPoint(x: x + waveWidth / 2, y: goingUp ? midY - amplitude : midY + amplitude)
            )
            goingUp.toggle()
            x = nextX
        }
 
        return path
    }
}

#Preview {
    WaveDashedLine()
}
