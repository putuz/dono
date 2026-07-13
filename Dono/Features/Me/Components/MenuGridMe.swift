//
//  MenuGridMe.swift
//  Dono
//
//  Created by Bahtiar on 11/07/26.
//

import SwiftUI

struct MeMenuItem: Identifiable {
    let id = UUID()
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
}
 
struct MenuGridMe: View {
 
    let items: [MeMenuItem] = [
        MeMenuItem(icon: "wallet.pass.fill", iconColor: .blue, title: "Balance", subtitle: "Let's Top Up"),
        MeMenuItem(icon: "cross.fill", iconColor: .blue, title: "DANA+", subtitle: "Daily Reward!"),
        MeMenuItem(icon: "scope", iconColor: .red, title: "DANA Goals", subtitle: "Create goals!"),
        MeMenuItem(icon: "face.smiling.fill", iconColor: .orange, title: "Family Account", subtitle: "Let's Activate!"),
        MeMenuItem(icon: "banknote.fill", iconColor: .orange, title: "eMAS", subtitle: "Start Investing"),
        MeMenuItem(icon: "storefront.fill", iconColor: .blue, title: "Rekan DANA", subtitle: "Get Profits!")
    ]
 
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
 
    var income: String = "Rp0"
    var expense: String = "Rp0"
 
    var body: some View {
        VStack(spacing: 0) {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(items) { item in
                    Button {
                        print("\(item.title) tapped")
                    } label: {
                        VStack(spacing: 8) {
                            Circle()
                                .fill(item.iconColor.opacity(0.15))
                                .frame(width: 52, height: 52)
                                .overlay {
                                    Image(systemName: item.icon)
                                        .font(.system(size: 22))
                                        .foregroundStyle(item.iconColor)
                                }
 
                            VStack(spacing: 2) {
                                Text(item.title)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(.primary)
 
                                Text(item.subtitle)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundStyle(.blue)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 20)
            .padding(.bottom, 16)
 
            Divider()
 
            HStack(spacing: 0) {
                SummaryItem(
                    icon: "arrow.down",
                    iconColor: .green,
                    label: "Income",
                    amount: income
                )
 
                Divider()
                    .frame(height: 32)
 
                SummaryItem(
                    icon: "arrow.up",
                    iconColor: .orange,
                    label: "Expense",
                    amount: expense
                )
            }
            .padding(.vertical, 16)
        }
        .padding(.horizontal, 10)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
        .shadow(radius: 2)
    }
}
 
private struct SummaryItem: View {
    let icon: String
    let iconColor: Color
    let label: String
    let amount: String
 
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(iconColor.opacity(0.15))
                .frame(width: 36, height: 36)
                .overlay {
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(iconColor)
                }
 
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
 
                Text(amount)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.primary)
            }
 
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


#Preview {
    MenuGridMe()
}
