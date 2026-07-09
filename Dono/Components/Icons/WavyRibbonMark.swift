//
//  WavyRibbonMark.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI


struct WavyRibbonMark: View {
    var badgeColor: Color = .blue
    var ribbonColor: Color = .white
    var size: CGFloat = 96
 
    var body: some View {
        ZStack {
            Circle()
                .fill(badgeColor)
                .frame(width: size, height: size)
                .shadow(color: badgeColor.opacity(0.3), radius: 6, x: 0, y: 3)
 
            WavyFlagRibbon(waveCount: 1.0, amplitude: 0.10, thickness: 0.44)
                .fill(ribbonColor)
                .frame(width: size * 0.55, height: size * 0.35)
        }
    }
}

#Preview {
    WavyRibbonMark()
}
