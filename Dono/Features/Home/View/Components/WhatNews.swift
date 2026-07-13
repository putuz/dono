//
//  WhatNews.swift
//  Dono
//
//  Created by Bahtiar on 11/07/26.
//

import SwiftUI

struct NewsItem: Identifiable {
    let id = UUID()
    let iconText: String
    let iconBackground: Color
    let title: String
    let subtitle: String
}
 
// MARK: - Reusable row
 
struct NewsRow: View {
    let item: NewsItem
 
    var body: some View {
        HStack(spacing: 25) {
            Circle()
                .fill(item.iconBackground)
                .frame(width: 40, height: 40)
                .overlay {
                    Text(item.iconText)
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                }
 
            VStack(alignment: .leading, spacing: 0) {
                Text(item.title)
                    .font(.callout)
                    .fontWeight(.bold)
 
                Text(item.subtitle)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
 
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
 
// MARK: - What's New section
 
struct WhatNews: View {
    let newsItems: [NewsItem] = [
        NewsItem(
            iconText: "DANA",
            iconBackground: .blue,
            title: "Festival Bola Dunia",
            subtitle: "Dapetin Total Miliaran Rupiah"
        ),
        NewsItem(
            iconText: "PROMO",
            iconBackground: .orange,
            title: "Diskon Ongkir 50%",
            subtitle: "Belanja lebih hemat tiap hari"
        ),
        NewsItem(
            iconText: "SAFE",
            iconBackground: .green,
            title: "Fitur Keamanan Baru",
            subtitle: "Lindungi akunmu lebih maksimal"
        ),
        NewsItem(
            iconText: "GIFT",
            iconBackground: .purple,
            title: "Bagi-bagi Saldo Gratis",
            subtitle: "Klaim sebelum kehabisan!"
        )
    ]
 
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("What's New")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    Text("The best news of the week!")
                }
 
                Spacer()
 
                Button {
                    print("View All Tapped")
                } label: {
                    Text("VIEW ALL")
                        .font(.caption)
                        .foregroundStyle(.blue)
                        .frame(height: 40)
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                }
            }
 
            VStack(spacing: 0) {
                ForEach(newsItems) { item in
                    NewsRow(item: item)
                }
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .black.opacity(0.25), radius: 4, y: 2)
        .padding(.horizontal)
    }
}


#Preview {
    WhatNews()
}
