//
//  StickyHeadWallet.swift
//  Dono
//
//  Created by Bahtiar on 13/07/26.
//

import SwiftUI

struct AddPaymentMethodSheet: View {

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 4)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Add Payment Method")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.top, 8)

                PaymentSection(
                    title: "Save the Payment Methods",
                    options: [
                        AddOption(icon: "creditcard", title: "Bank Cards"),
                        AddOption(icon: "building.columns", title: "Bank Account")
                    ],
                    columns: columns
                )

                PaymentSection(
                    title: "Invest Time",
                    options: [
                        AddOption(icon: "cube.fill", title: "eMAS"),
                        AddOption(icon: "target", title: "DANA Goals"),
                        AddOption(icon: "plus.circle.fill", title: "DANA+")
                    ],
                    columns: columns
                )

                PaymentSection(
                    title: "Voucher & Ticket Purchase",
                    options: [
                        AddOption(icon: "tag.fill", title: "DANA Deals"),
                        AddOption(icon: "star.fill", title: "A+ Rewards")
                    ],
                    columns: columns
                )
            }
            .padding(20)
        }
        .scrollIndicators(.never)
    }
}

// MARK: - Model opsi per item
struct AddOption: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
}

// MARK: - Section reusable (judul + grid)
struct PaymentSection: View {
    let title: String
    let options: [AddOption]
    let columns: [GridItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title.uppercased())
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.gray)

            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(options) { option in
                    AddOptionGridItem(icon: option.icon, title: option.title)
                }
            }
        }
    }
}

// MARK: - Item grid satuan (icon bulat + label di bawah)
struct AddOptionGridItem: View {
    let icon: String
    let title: String

    var body: some View {
        Button {
            // aksi tap menu
        } label: {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.blue)
                    .frame(width: 52, height: 52)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Circle())

                Text(title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
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

                    Text("DONO\nPROTECTION")
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
                .presentationDetents([.height(280)])
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
