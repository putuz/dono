//
//  PaymentCard.swift
//  Dono
//
//  Created by Bahtiar on 13/07/26.
//

import SwiftUI

// MARK: - Kartu pembayaran (reusable, dipakai untuk semua jenis kartu)
struct PaymentCard: View {
    let card: PaymentCardModel
 
    var body: some View {
        VStack(spacing: 0) {
            // Bagian atas: gradient + nama issuer
            HStack(spacing: 10) {
                Circle()
                    .fill(Color.white)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Image(systemName: card.iconSystemName)
                            .font(.system(size: 13))
                            .foregroundColor(card.gradientColors.first ?? .blue)
                    )
 
                Text(card.issuerName.uppercased())
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                    .tracking(0.5)
 
                Spacer()
            }
            .padding(16)
            .background(
                LinearGradient(
                    colors: card.gradientColors,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
 
            // Bagian bawah: saldo + nomor kartu + deskripsi + aksi
            VStack(alignment: .leading, spacing: 12) {
                Text(card.cardNumber)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundColor(.gray)
                    .tracking(8)
                    .padding(.vertical)
 
                Text(card.description)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .padding(.vertical)
 
                HStack {
                    Button {
                        // aksi buka kartu
                    } label: {
                        Text(card.primaryActionTitle)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 18)
                            .padding(.vertical, 8)
                            .overlay(
                                Capsule().stroke(Color.gray.opacity(0.35), lineWidth: 1)
                            )
                    }
 
                    Spacer()
                }
            }
            .padding(16)
            .background(Color.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
    }
}

#Preview {
    PaymentCard(
            card: PaymentCardModel(
                iconSystemName: "flag.fill",
                issuerName: "DANA",
                cardNumber: "•••• •••• •••• 4821",
                description: "Saldo DANA kamu",
                gradientColors: [
                    Color(red: 0.12, green: 0.42, blue: 0.95),
                    Color(red: 0.35, green: 0.62, blue: 0.98)
                ],
                primaryActionTitle: "OPEN"
            )
        )
}
