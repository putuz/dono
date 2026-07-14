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
    
    let cards: [PaymentCardModel] = [
        PaymentCardModel(
            iconSystemName: "wallet.pass.fill",
            issuerName: "DANA",
            cardNumber: "•••• •••• •••• 4821",
            description: "Saldo DANA kamu",
            gradientColors: [Color(red: 0.06, green: 0.47, blue: 0.98), Color(red: 0.02, green: 0.28, blue: 0.85)],
            primaryActionTitle: "OPEN"
        ),
        PaymentCardModel(
            iconSystemName: "building.columns.fill",
            issuerName: "BCA",
            cardNumber: "•••• •••• •••• 1092",
            description: "Kartu Debit BCA",
            gradientColors: [Color(red: 0.0, green: 0.35, blue: 0.75), Color(red: 0.0, green: 0.16, blue: 0.45)],
            primaryActionTitle: "OPEN"
        ),
        PaymentCardModel(
            iconSystemName: "creditcard.fill",
            issuerName: "Mandiri",
            cardNumber: "•••• •••• •••• 7734",
            description: "Kartu Kredit Mandiri",
            gradientColors: [Color(red: 0.95, green: 0.65, blue: 0.05), Color(red: 0.85, green: 0.35, blue: 0.02)],
            primaryActionTitle: "OPEN"
        )
    ]
 
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

#Preview {
    WalletView()
}
