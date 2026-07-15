//
//  ScanResultOverlay.swift
//  Dono
//
//  Created by Bahtiar on 14/07/26.
//

import SwiftUI

struct ScanResultOverlay: View {
    let scannedCode: String?
    let onScanAgain: () -> Void

    var body: some View {
        VStack {
            Spacer()
            if let scannedCode {
                VStack(spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.green)
                    Text("QRIS Terdeteksi")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(scannedCode)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                        .truncationMode(.middle)
                        .padding(.horizontal)
                }
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding()
                .task(id: scannedCode) {
                    try? await Task.sleep(for: .seconds(2))
                    onScanAgain()
                }
            }
        }
    }
}

#Preview {
    ScanResultOverlay(
            scannedCode: "00020101021126650016COM.NOBUBANK.WWW01189360050300000879140214543180175896650303UMI51440014ID.CO.QRIS.WWW0215ID10253662440303UMI5204541153033605802ID5912Dono Store6007Jakarta6105123406304ABCD",
            onScanAgain: {}
        )
}
