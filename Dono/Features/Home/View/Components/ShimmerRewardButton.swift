//
//  ShimmerRewardButton.swift
//  Dono
//
//  Created by Bahtiar on 10/07/26.
//

import SwiftUI

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
                        .font(.system(size: 13, weight: .bold))
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
            .padding(.horizontal, 8)
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

#Preview {
    ShimmerRewardButton(onRewardTap: {})
}
