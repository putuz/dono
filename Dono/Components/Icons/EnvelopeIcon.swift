//
//  EnvelopeIcon.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

// MARK: - Composed icon
struct EnvelopeIcon: View {
    var size: CGFloat = 96
    var colorShape: Color = Color.gray
    var colorFont: Color = Color.gray
    var iconSize: CGFloat = 14

    var body: some View {
        ZStack {
 
            OpenBracketFrame(cornerRadius: size * 0.12, gapSize: 0.26)
                .stroke(colorShape, lineWidth: size * 0.045)
                .frame(width: size * 0.6, height: size * 0.6)
                .offset(x: -size * 0.02, y: size * 0.06)
 
            Image(systemName: "chevron.down.circle")
                .resizable()
                .foregroundStyle(colorShape)
                .frame(width: size * 0.20, height: size * 0.20)
                .offset(x: size * 0.23, y: -size * 0.20)
 
            Image(systemName: "envelope")
                .foregroundStyle(colorFont)
                .font(.system(size: iconSize, weight: .bold))
                .frame(width: size * 0.30, height: size * 0.30)
                .offset(y: size * 0.04)
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    EnvelopeIcon(size: 120)
}
