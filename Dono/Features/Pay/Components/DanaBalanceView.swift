//
//  DanaBalanceView.swift
//  Dono
//
//  Created by Bahtiar on 15/07/26.
//
import SwiftUI
 
/// Halaman kedua di PayView: nampilin saldo dan QRIS milik user sendiri
/// supaya bisa nerima pembayaran (bukan buat scan).
struct DanaBalanceView: View {
    /// Ganti dengan data asli (misal dari ViewModel/API) saat sudah terhubung ke backend.
    let qrisPayload: String
 
    var body: some View {
        VStack(spacing: 20) {
            showQRISCard
        }
        .padding(.horizontal)
    }
    
    private var showQRISCard: some View {
        VStack(spacing: 14) {
            Text("Show My QRIS")
                .font(.headline)
 
            if let qrImage = QRCodeGenerator.generate(from: qrisPayload) {
                Image(uiImage: qrImage)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(12)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 200, height: 200)
                    .overlay(Text("QR gagal dibuat").font(.caption).foregroundColor(.secondary))
            }
 
            Text("Tunjukkan kode ini ke merchant untuk menerima pembayaran")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
        }
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
 
#Preview {
    DanaBalanceView(qrisPayload: "00020101021126...dummy-qris-payload")
}
