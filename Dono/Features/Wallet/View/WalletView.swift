//
//  WalletView.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

struct WalletView: View {
    private func refreshData() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
    
    let cards: [PaymentCardModel] = []
 
    var body: some View {
        VStack(spacing: 0) {
            StickyHeadWallet()
 
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Jarak kecil supaya "PAYMENT METHOD" tidak
                        // menempel persis di bawah search bar
                        Spacer().frame(height: 8)
 
                        PaymentMethodSection(cards: cards)
 
                        WalletFooter()
 
                        Spacer(minLength: 120)
 
                        Text("Version 2.133.1")
                            .foregroundStyle(.gray)
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                    }
                }
                .scrollIndicators(.never)
                .scrollContentBackground(.hidden)
                .refreshable {
                    await refreshData()
                }
                .onAppear {
                    UIRefreshControl.appearance().tintColor = .white
                }
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}
 
// MARK: - Model data untuk satu kartu pembayaran
struct PaymentCardModel: Identifiable {
    let id = UUID()
    let iconSystemName: String      // ikon di badge bulat kiri atas
    let issuerName: String          // contoh: "DANA", "BCA", "Mandiri"
    let cardNumber: String          // contoh: "•••• •••• •••• 4821"
    let description: String         // teks kecil di bawah nomor kartu
    let gradientColors: [Color]     // warna gradient header kartu
    let primaryActionTitle: String  // contoh: "OPEN"
}
 
// MARK: - Section "PAYMENT METHOD" (menampilkan banyak kartu)
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
    WalletView()
}
