//
//  WalletFooter.swift
//  Dono
//
//  Created by Bahtiar on 13/07/26.
//

import SwiftUI

// MARK: - Garis putus-putus bergelombang + watermark "WALLET"
struct WalletFooter: View {
    var body: some View {
        VStack(spacing: 20) {
            WaveDashedLine()
                .stroke(style: StrokeStyle(lineWidth: 1.2, dash: [4, 4]))
                .foregroundColor(.gray.opacity(0.35))
                .frame(height: 14)
                .padding(.horizontal, 20)
 
            HStack(spacing: 6) {
                WavyRibbonMark(size: 18)
 
                Text("WALLET")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray.opacity(0.45))
                    .tracking(1)
            }
        }
    }
}

#Preview {
    WalletFooter()
}
