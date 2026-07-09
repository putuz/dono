//
//  TopUpIcon.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

// MARK: - Composed icon
struct TopUpIcon: View {
    var size: CGFloat = 96
    var colorShape: Color = Color.gray
    var colorPlus: Color = Color.gray
 
    var body: some View {
        ZStack {
 
            OpenBracketFrame(cornerRadius: size * 0.12, gapSize: 0.26)
                .stroke(colorShape, lineWidth: size * 0.045)
                .frame(width: size * 0.6, height: size * 0.6)
                .offset(x: -size * 0.02, y: size * 0.06)
 
            UpRightArrow()
                .fill(colorShape)
                .frame(width: size * 0.28, height: size * 0.28)
                .offset(x: size * 0.22, y: -size * 0.22)
 
            PlusShape(armThickness: 0.24)
                .fill(colorPlus)
                .frame(width: size * 0.24, height: size * 0.24)
                .offset(x: -size * 0.02, y: size * 0.04)
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    TopUpIcon()
}
