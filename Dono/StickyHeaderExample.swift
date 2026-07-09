//
//  StickyHeaderExample.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

// MARK: - The header content itself
//struct StickyBalanceHeader: View {
//    @State private var isBalanceHidden = true
//    var balanceText: String = "1.250.000"
//    var onRewardTap: () -> Void = {}
// 
//    var body: some View {
//        HStack {
//            // Left side: icon + balance + eye toggle
//            HStack(spacing: 8) {
//                WavyRibbonMark(badgeColor: .white, ribbonColor: .blue, size: 24)
// 
//                Text(isBalanceHidden ? "•••" : "Rp\(balanceText)")
//                    .foregroundStyle(.white)
//                    .font(.system(size: 16, weight: .medium))
//                    .contentTransition(.numericText())
// 
//                Button {
//                    withAnimation(.easeInOut(duration: 0.2)) {
//                        isBalanceHidden.toggle()
//                    }
//                } label: {
//                    Image(systemName: isBalanceHidden ? "eye" : "eye.slash")
//                        .foregroundStyle(.white.opacity(0.85))
//                        .font(.system(size: 14))
//                }
//                .buttonStyle(.plain)
//            }
// 
//            Spacer()
// 
//            // Right side: reward pill button
//            Button(action: onRewardTap) {
//                Text("Get daily reward!")
//                    .font(.system(size: 13, weight: .semibold))
//                    .foregroundStyle(.white)
//                    .padding(.horizontal, 14)
//                    .padding(.vertical, 8)
//                    .background(
//                        Capsule()
//                            .fill(Color.white.opacity(0.18))
//                            .overlay(
//                                Capsule().stroke(Color.white.opacity(0.4), lineWidth: 1)
//                            )
//                    )
//            }
//            .buttonStyle(.plain)
//        }
//        .padding(.horizontal, 16)
//        .padding(.vertical, 12)
//        .background(Color(red: 0.35, green: 0.62, blue: 0.93))
//    }
//}
 
// MARK: - Example usage: header stays put, content scrolls beneath it
struct StickyHeaderExample: View {
    var body: some View {
        VStack(spacing: 0) {
            // Not inside the ScrollView — this is the entire trick.
            StickyBalanceHeader(onRewardTap: {
                print("Reward tapped")
            })
 
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(0..<6, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.15))
                            .frame(height: 200)
                            .overlay(Text("Item \(i)"))
                            .padding(.horizontal)
                    }
                }
                .padding(.top, 12)
            }
        }
    }
}


#Preview {
    StickyHeaderExample()
}
