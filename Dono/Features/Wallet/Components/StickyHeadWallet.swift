//
//  StickyHeadWallet.swift
//  Dono
//
//  Created by Bahtiar on 13/07/26.
//

import SwiftUI

struct AddPaymentMethodSheet: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Add Payment Method")
                .font(.system(size: 18, weight: .semibold))

            VStack(spacing: 12) {
                AddOptionRow(icon: "creditcard", title: "Debit / Credit Card")
                AddOptionRow(icon: "building.columns", title: "Bank Account")
                AddOptionRow(icon: "banknote", title: "E-Wallet")
            }

            Spacer()
        }
        .padding(20)
        .padding(.top, 8)
    }
}

struct AddOptionRow: View {
    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.blue)
                .frame(width: 32, height: 32)
                .background(Color.blue.opacity(0.1))
                .clipShape(Circle())

            Text(title)
                .font(.system(size: 15, weight: .medium))

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}

struct StickyHeadWallet: View {
    var body: some View {
        // Pakai padding (bukan offset) supaya tinggi search bar yang
        // "menonjol" keluar dari header ikut dihitung oleh ZStack,
        // jadi tidak akan ketutup oleh konten ScrollView di bawahnya.
        VStack(spacing: 0) {
            WalletStickyHeader()
 
            WalletSearchBar()
        }
    }
}
 
// MARK: - Header yang menempel (sticky)
struct WalletStickyHeader: View {
    @State private var showAddSheet = false

    var body: some View {
        ZStack {
            Text("Wallet")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)

                    Text("DANA\nPROTECTION")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                        .lineSpacing(1)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer()

                Button {
                    showAddSheet = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.blue)
                        .frame(width: 32, height: 32)
                        .background(Color.white)
                        .clipShape(Circle())
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 24)
        .frame(maxWidth: .infinity)
        .background(.blue)
        .sheet(isPresented: $showAddSheet) {
            AddPaymentMethodSheet()
                .presentationDetents([.height(280), .medium])
                .presentationDragIndicator(.visible)
        }
    }
}
 
// MARK: - Search bar yang mengambang di antara header & konten
struct WalletSearchBar: View {
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .font(.system(size: 16, weight: .medium))
 
            Text("Looking for something in wallet?")
                .font(.system(size: 15))
                .foregroundColor(.gray)
 
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    StickyHeadWallet()
}
