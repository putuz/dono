//
//  CameraPermissionDeniedView.swift
//  Dono
//
//  Created by Bahtiar on 14/07/26.
//

import SwiftUI

/// Tampil ketika izin kamera belum diberikan / ditolak.
struct CameraPermissionDeniedView: View {
    let onOpenSettings: () -> Void
 
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "camera.fill")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            Text("Akses Kamera Dibutuhkan")
                .font(.headline)
            Text("Aktifkan izin kamera di Pengaturan untuk bisa scan QRIS.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Button("Buka Pengaturan", action: onOpenSettings)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
