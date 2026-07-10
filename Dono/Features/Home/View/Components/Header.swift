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
        VStack(spacing: 0) {
            StickyBalanceHeader(balanceText: "0") { print("Hello") }
            SubHeader(items: [
                SubHeaderItem(title: "iPhone 17", subtitle: "Siap Kamu Klaim"),
                SubHeaderItem(title: "Beli VIP Pass", subtitle: "& Dapetin Hadiahnya")
            ])
        }
        
    }
}

#Preview {
    Header()
        .preferredColorScheme(.dark)
}
