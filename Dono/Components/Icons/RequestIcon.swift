//
//  RequestIcon.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

struct RequestIcon: View {
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
 
            DownRightArrow()
                .fill(colorShape)
                .frame(width: size * 0.28, height: size * 0.28)
                .offset(x: size * 0.22, y: -size * 0.22)
 
            Text("Rp")
                .foregroundStyle(colorFont)
                .font(.system(size: iconSize, weight: .bold))
                .frame(width: size * 0.30, height: size * 0.30)
                .offset(x: -size * 0.02, y: size * 0.04)
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    RequestIcon()
}
