//
//  DownRightArrow.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

struct DownRightArrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let shaftWidth = w * 0.15
        let headWidth = w * 0.65

        // Shaft: straight vertical line, top-center to bottom-center
        let start = CGPoint(x: w * 0.5, y: h * 0.05)
        let end = CGPoint(x: w * 0.5, y: h * 0.75)

        let angle = atan2(end.y - start.y, end.x - start.x)
        let perp = CGPoint(x: -sin(angle) * shaftWidth / 2, y: cos(angle) * shaftWidth / 2)
        path.move(to: CGPoint(x: start.x + perp.x, y: start.y + perp.y))
        path.addLine(to: CGPoint(x: end.x + perp.x, y: end.y + perp.y))
        path.addLine(to: CGPoint(x: end.x - perp.x, y: end.y - perp.y))
        path.addLine(to: CGPoint(x: start.x - perp.x, y: start.y - perp.y))
        path.closeSubpath()

        // Arrowhead: tip at the bottom, base level with the shaft end
        var head = Path()
        let headTip = CGPoint(x: w * 0.5, y: h * 0.95)
        let headBase1 = CGPoint(x: w * 0.5 - headWidth / 2, y: end.y)
        let headBase2 = CGPoint(x: w * 0.5 + headWidth / 2, y: end.y)

        head.move(to: headBase1)
        head.addLine(to: headTip)
        head.addLine(to: headBase2)
        head.addLine(to: end)
        head.closeSubpath()

        path.addPath(head)
        return path
    }
}
