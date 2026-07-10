//
//  Feed.swift
//  Dono
//
//  Created by Bahtiar on 10/07/26.
//

import SwiftUI

struct FeedItem {
    let brand: String
    let text: String
    let emoji: String?
    let linkText: String
    let onTapLink: () -> Void
}

struct Feed: View {
    let items: [FeedItem]
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(items.indices, id: \.self) { index in
                FeedRow(item: items[index])
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 10)
        .shadow(radius: 2)
    }
}

struct FeedRow: View {
    let item: FeedItem
    
    var body: some View {
        HStack(spacing: 8) {
            WavyRibbonMark(size: 22)
            
            Spacer()
            
            HStack(spacing: 4) {
                Text(item.brand)
                    .font(.caption)
                    .fontWeight(.bold)
                Text(item.text)
                    .font(.caption)
                Button(action: item.onTapLink) {
                    Text(item.linkText)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                if let emoji = item.emoji {
                    Text(emoji)
                        .font(.subheadline)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)
            
            Spacer()
            
            Image(systemName: "megaphone.fill")
                .foregroundStyle(.blue)
        }
    }
}

#Preview {
    Feed(items: [
        FeedItem(
            brand: "DANA",
            text: "backs a team at ⚽️",
            emoji: nil,
            linkText: "Festival Bola Dunia",
            onTapLink: { print("Festival Bola Dunia tapped") }
        ),
        FeedItem(
            brand: "DANA",
            text: "Play",
            emoji: "🕹️",
            linkText: "Joy Games for Double Beans",
            onTapLink: { print("Joy Games tapped") }
        ),
        FeedItem(
            brand: "DANA",
            text: "Play",
            emoji: "🕹️",
            linkText: "Joy Games for Double Beans",
            onTapLink: { print("Joy Games tapped") }
        ),
        FeedItem(
            brand: "DANA",
            text: "Play",
            emoji: "🕹️",
            linkText: "Joy Games for Double Beans",
            onTapLink: { print("Joy Games tapped") }
        )
    ])
}
