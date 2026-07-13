//
//  StickyHeadWallet.swift
//  Dono
//
//  Created by Bahtiar on 13/07/26.
//

import SwiftUI

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
 
    var body: some View {
        // "Wallet" diletakkan di ZStack supaya posisinya benar-benar center,
        // tidak terpengaruh lebar konten kiri (DANA PROTECTION) atau kanan (tombol +)
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
                    // aksi tambah
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
