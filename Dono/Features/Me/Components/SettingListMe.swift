//
//  SettingListMe.swift
//  Dono
//
//  Created by Bahtiar on 12/07/26.
//

import SwiftUI

struct SettingsMeItem: Identifiable {
    let id = UUID()
    let icon: String
    let iconColor: Color
    let iconBackground: Color?   // nil = plain icon, no background shape
    let title: String
    let subtitle: String?
    let onTap: () -> Void
}

struct SettingListMe: View {
    let items: [SettingsMeItem] = [
        SettingsMeItem(
            icon: "doc.text.fill",
            iconColor: .white,
            iconBackground: .orange,
            title: "My Bills",
            subtitle: nil,
            onTap: { print("My Bills tapped") }
        ),
        SettingsMeItem(
            icon: "percent",
            iconColor: .white,
            iconBackground: .orange,
            title: "Voucher Promo",
            subtitle: nil,
            onTap: { print("Voucher Promo tapped") }
        ),
        SettingsMeItem(
            icon: "gearshape.fill",
            iconColor: .white,
            iconBackground: .blue,
            title: "Settings",
            subtitle: nil,
            onTap: { print("Settings tapped") }
        ),
        SettingsMeItem(
            icon: "info.circle.fill",
            iconColor: .white,
            iconBackground: .green,
            title: "General Info",
            subtitle: nil,
            onTap: { print("General Info tapped") }
        ),
        SettingsMeItem(
            icon: "person.crop.circle.fill",
            iconColor: .white,
            iconBackground: .blue,
            title: "DIANA is here to help!",
            subtitle: "Let's chat if you need assistance.",
            onTap: { print("DIANA tapped") }
        )
    ]
 
    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                Button {
                    item.onTap()
                } label: {
                    HStack(spacing: 14) {
                        ZStack {
                            if let bg = item.iconBackground {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(bg)
                                    .frame(width: 36, height: 36)
                            }
 
                            Image(systemName: item.icon)
                                .font(.system(size: item.iconBackground == nil ? 28 : 16))
                                .foregroundStyle(item.iconColor)
                        }
 
                        VStack(alignment: .leading, spacing: 2) {
                            Text(item.title)
                                .font(.system(size: 16))
                                .foregroundStyle(.primary)
 
                            if let subtitle = item.subtitle {
                                Text(subtitle)
                                    .font(.system(size: 13))
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                        }
 
                        Spacer(minLength: 0)
 
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.tertiary)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
 
                // Divider between rows — skipped after the last item.
                if index < items.count - 1 {
                    Divider()
                }
            }
        }
        .padding(.vertical, 8)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
        .shadow(radius: 2)
    }
}

#Preview {
    SettingListMe()
}
