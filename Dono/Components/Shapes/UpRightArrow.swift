//
//  UpRightArrow.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

// MARK: - 2. The arrow shape (pointing straight up)
struct UpRightArrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height

        let shaftWidth = w * 0.15
        let headWidth = w * 0.65

        // Shaft (straight vertical line, bottom-center to top-center)
        let start = CGPoint(x: w * 0.5, y: h * 0.95)
        let end = CGPoint(x: w * 0.5, y: h * 0.25)

        // Build shaft as a thick line using perpendicular offset
        let angle = atan2(end.y - start.y, end.x - start.x)
        let perp = CGPoint(x: -sin(angle) * shaftWidth / 2, y: cos(angle) * shaftWidth / 2)

        path.move(to: CGPoint(x: start.x + perp.x, y: start.y + perp.y))
        path.addLine(to: CGPoint(x: end.x + perp.x, y: end.y + perp.y))
        path.addLine(to: CGPoint(x: end.x - perp.x, y: end.y - perp.y))
        path.addLine(to: CGPoint(x: start.x - perp.x, y: start.y - perp.y))
        path.closeSubpath()

        // Arrowhead: tip above the shaft end, base sitting right at the shaft end's height
        var head = Path()
        let headTip = CGPoint(x: w * 0.5, y: h * 0.05)          // topmost point
        let headBase1 = CGPoint(x: w * 0.5 - headWidth / 2, y: end.y) // left base, level with shaft end
        let headBase2 = CGPoint(x: w * 0.5 + headWidth / 2, y: end.y) // right base, level with shaft end

        head.move(to: headBase1)
        head.addLine(to: headTip)
        head.addLine(to: headBase2)
        head.addLine(to: end) // back to shaft-end center, creating the classic notched arrow look
        head.closeSubpath()

        path.addPath(head)
        return path
    }
}
