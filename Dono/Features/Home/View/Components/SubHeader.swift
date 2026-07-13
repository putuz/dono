//
//  SubHeaderHome.swift
//  Dono
//
//  Created by Bahtiar on 10/07/26.
//

import SwiftUI

struct SubHeaderItem {
    let title: String
    let subtitle: String
}

struct SubHeaderHome: View {
    let items: [SubHeaderItem]
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                ForEach(items.indices, id: \.self) { index in
                    if index == currentIndex {
                        VStack(spacing: 0) {
                            Text(items[index].title)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                            Text(items[index].subtitle)
                                .foregroundStyle(.white)

                            if index == 1 {
                                Button {
                                    print("Button tapped for index 1")
                                } label: {
                                    Text("Beli")
                                        .fontWeight(.bold)
                                        .frame(width: 100 ,height: 35)
                                        .background(Color.yellow)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                        .padding()
                        .transition(.asymmetric(
                            insertion: .move(edge: .top).combined(with: .opacity),
                            removal: .move(edge: .bottom).combined(with: .opacity)
                        ))
                    }
                }
            }
            .frame(height: 110) // fix tinggi biar gak ngikut konten
            .animation(.easeInOut(duration: 0.5), value: currentIndex)
        }
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .onReceive(timer) { _ in
            currentIndex = (currentIndex + 1) % items.count
        }
    }
}

#Preview {
    SubHeaderHome(items: [SubHeaderItem(title: "iPhone 17", subtitle: "Siap Kamu Klaim"), SubHeaderItem(title: "Beli VIP Pass", subtitle: "& Dapetin Hadiahnya")])
}
