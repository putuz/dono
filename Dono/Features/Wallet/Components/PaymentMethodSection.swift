//
//  PaymentMethodSection.swift
//  Dono
//
//  Created by Bahtiar on 13/07/26.
//

import SwiftUI

struct PaymentMethodSection: View {
    let cards: [PaymentCardModel]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("PAYMENT METHOD")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.gray)

                Spacer()

                Text("\(cards.count) CARD")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)
            }

            if cards.isEmpty {
                ContentUnavailableView(
                    "No Payment Method",
                    systemImage: "creditcard",
                    description: Text("Add a payment method to get started.")
                )
            } else {
                VStack(spacing: 16) {
                    ForEach(cards) { card in
                        PaymentCard(card: card)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    PaymentMethodSection(cards: [
        PaymentCardModel(
            iconSystemName: "wallet.pass.fill",
            issuerName: "DANA",
            cardNumber: "•••• •••• •••• 4821",
            description: "Saldo DANA kamu",
            gradientColors: [Color(red: 0.06, green: 0.47, blue: 0.98), Color(red: 0.02, green: 0.28, blue: 0.85)],
            primaryActionTitle: "OPEN"
        )
    ])
}
