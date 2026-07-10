//
//  MenuGrid.swift
//  Dono
//
//  Created by Bahtiar on 10/07/26.
//

import SwiftUI

struct MenuItem {
    let icon: String
    let label: String
    let onTap: () -> Void
}

struct MenuGrid: View {
    let items: [MenuItem]
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 4)

    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 24) {
            ForEach(items.indices, id: \.self) { index in
                Button(action: items[index].onTap) {
                    VStack(spacing: 0) {
                        Image(systemName: items[index].icon)
                            .font(.system(size: 24))
                            .foregroundStyle(.blue)
                            .frame(width: 44, height: 44)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        Text(items[index].label)
                            .font(.caption)
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .frame(width: 50)
                            .frame(height: 32) // tinggi tetap buat 1 atau 2 baris teks
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 10)
        .shadow(radius: 2)
        .padding(.top, -30)
    }
}

#Preview {
    MenuGrid(items: [
        MenuItem(icon: "gift.fill", label: "Daily Rewards", onTap: { print("Daily Rewards") }),
        MenuItem(icon: "circle.hexagonpath.fill", label: "DANA Points", onTap: { print("DANA Points") }),
        MenuItem(icon: "gift.circle.fill", label: "Redeem Rewards", onTap: { print("Redeem Rewards") }),
        MenuItem(icon: "apple.logo", label: "Apple Zone", onTap: { print("Apple Zone") }),
        MenuItem(icon: "creditcard.fill", label: "Pulsa & Data", onTap: { print("Pulsa & Data") }),
        MenuItem(icon: "bolt.fill", label: "Electricity", onTap: { print("Electricity") }),
        MenuItem(icon: "star.circle.fill", label: "A+ Rewards", onTap: { print("A+ Rewards") }),
        MenuItem(icon: "square.grid.2x2.fill", label: "View All", onTap: { print("View All") })
    ])
}
