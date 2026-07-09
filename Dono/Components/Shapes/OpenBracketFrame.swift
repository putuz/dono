//
//  OpenBracketFrame.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

// MARK: - 1. The open bracket / frame shape
struct OpenBracketFrame: Shape {
    var cornerRadius: CGFloat = 14
    /// How much of the top-right corner to leave open, in degrees of arc skipped.
    var gapSize: CGFloat = 0.35 // fraction of the top edge + right edge near the corner
 
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let r = cornerRadius
 
        // Start partway along the top edge (leaving a gap before the top-right corner)
        let topGapStart = w * (1 - gapSize)
 
        path.move(to: CGPoint(x: r, y: 0))
        path.addLine(to: CGPoint(x: topGapStart, y: 0)) // top edge, stops short of corner
 
        // Jump to right edge, starting partway down (after the gap)
        let rightGapEnd = h * gapSize
        path.move(to: CGPoint(x: w, y: rightGapEnd))
        path.addLine(to: CGPoint(x: w, y: h - r))
        path.addArc(center: CGPoint(x: w - r, y: h - r), radius: r,
                    startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
 
        // Bottom edge
        path.addLine(to: CGPoint(x: r, y: h))
        path.addArc(center: CGPoint(x: r, y: h - r), radius: r,
                    startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
 
        // Left edge
        path.addLine(to: CGPoint(x: 0, y: r))
        path.addArc(center: CGPoint(x: r, y: r), radius: r,
                    startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
 
        return path
    }
}
