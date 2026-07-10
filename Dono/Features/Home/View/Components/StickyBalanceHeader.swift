//
//  StickyBalanceHeader.swift
//  Dono
//
//  Created by Bahtiar on 10/07/26.
//

import SwiftUI

// MARK: - The header content itself
struct StickyBalanceHeader: View {
    @State private var isBalanceHidden = true
    var balanceText: String = "1.250.000"
    var onRewardTap: () -> Void = {}
 
    var body: some View {
        HStack {
            // Left side: icon + balance + eye toggle
            HStack(spacing: 8) {
                WavyRibbonMark(badgeColor: .white, ribbonColor: .blue, size: 24)
 
                Text(isBalanceHidden ? "•••" : "Rp\(balanceText)")
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .medium))
                    .contentTransition(.numericText())
 
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isBalanceHidden.toggle()
                    }
                } label: {
                    Image(systemName: isBalanceHidden ? "eye" : "eye.slash")
                        .foregroundStyle(.white.opacity(0.85))
                        .font(.system(size: 14))
                }
                .buttonStyle(.plain)
            }
 
            Spacer()
 
            // Right side: reward pill button
            ShimmerRewardButton(onRewardTap: onRewardTap)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.blue)
    }
}
