//
//  EnvelopeFlap.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

// MARK: - 2. The envelope flap (V shape)
struct EnvelopeFlap: Shape {
    var tipRadius: CGFloat = 10
 
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
 
        let topLeft = CGPoint(x: 0, y: 0)
        let tip = CGPoint(x: w * 0.5, y: h)
        let topRight = CGPoint(x: w, y: 0)
        
        func direction(from a: CGPoint, to b: CGPoint) -> CGPoint {
            let dx = b.x - a.x, dy = b.y - a.y
            let len = sqrt(dx * dx + dy * dy)
            return CGPoint(x: dx / len, y: dy / len)
        }
 
        let dirToLeft = direction(from: tip, to: topLeft)
        let dirToRight = direction(from: tip, to: topRight)
 
        let preTipLeft = CGPoint(x: tip.x + dirToLeft.x * tipRadius, y: tip.y + dirToLeft.y * tipRadius)
        let preTipRight = CGPoint(x: tip.x + dirToRight.x * tipRadius, y: tip.y + dirToRight.y * tipRadius)
 
        path.move(to: topLeft)
        path.addLine(to: preTipLeft)
        
        path.addQuadCurve(to: preTipRight, control: tip)
        path.addLine(to: topRight)
 
        return path
    }
}
