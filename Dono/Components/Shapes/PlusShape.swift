//
//  PlusShape.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

// MARK: - 3. The plus / cross shape
struct PlusShape: Shape {
    /// Thickness of each arm, as a fraction of the shape's width.
    var armThickness: CGFloat = 0.30
 
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        let armW = w * armThickness
        let armH = h * armThickness
 
        var path = Path()
        // Vertical bar
        path.addRect(CGRect(x: (w - armW) / 2, y: 0, width: armW, height: h))
        // Horizontal bar
        path.addRect(CGRect(x: 0, y: (h - armH) / 2, width: w, height: armH))
        return path
    }
}
