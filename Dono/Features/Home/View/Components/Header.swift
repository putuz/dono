//
//  Header.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

struct Header: View {
    @Environment(\.colorScheme) private var colorScheme
    var body: some View {
        StickyBalanceHeader(balanceText: "0") {
            print("Hello")
        }
    }
}

#Preview {
    Header()
        .preferredColorScheme(.dark)
}

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

struct ShimmerRewardButton: View {
    var onRewardTap: () -> Void
    let textAll: [String] = [
        "Get Daily Reward!",
        "Try DANA +"
    ]

    @State private var currentIndex = 0
    let timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()

    var body: some View {
        Button(action: onRewardTap) {
            ZStack {
                // Invisible stack — cuma buat "reserve" ukuran maksimal
                // berdasarkan teks terpanjang di antara semua textAll
                ForEach(textAll, id: \.self) { text in
                    Text(text)
                        .font(.system(size: 13, weight: .semibold))
                        .opacity(0)
                }

                // Teks asli yang animasinya jalan, ukurannya udah dikunci
                // sama ZStack di atas (karena ZStack ambil ukuran child terbesar)
                Text(textAll[currentIndex])
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.white)
                    .id(currentIndex)
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .move(edge: .top).combined(with: .opacity)
                        )
                    )
            }
            .clipped()
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                ZStack {
                    Capsule()
                        .fill(Color.blue.opacity(0.9))

                    GeometryReader { geo in
                        let w = geo.size.width
                        let h = geo.size.height

                        TimelineView(.animation) { context in
                            let t = context.date.timeIntervalSinceReferenceDate

                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.45))
                                    .frame(width: h * 1.6, height: h * 1.6)
                                    .blur(radius: 8)
                                    .offset(
                                        x: w * 0.01,
                                        y: sin(t * 1.4) * h * 0.29
                                    )

                                Circle()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(width: h * 0.8, height: h * 0.8)
                                    .blur(radius: 5)
                                    .offset(
                                        x: w * 0.16 + cos(t * 1.1) * w * 0.02,
                                        y: cos(t * 1.5) * h * 0.29
                                    )

                                Circle()
                                    .fill(Color.white.opacity(0.25))
                                    .frame(width: h * 0.5, height: h * 0.5)
                                    .blur(radius: 4)
                                    .offset(
                                        x: w * 0.1,
                                        y: sin(t * 1.7 + 1) * h * 0.2
                                    )
                            }
                        }
                    }
                    .clipShape(Capsule())

                    Capsule()
                        .stroke(Color(red: 0.15, green: 0.4, blue: 0.75), lineWidth: 2)
                }
            )
        }
        .buttonStyle(.plain)
        .onReceive(timer) { _ in
            withAnimation(.easeInOut(duration: 0.4)) {
                currentIndex = (currentIndex + 1) % textAll.count
            }
        }
    }
}
