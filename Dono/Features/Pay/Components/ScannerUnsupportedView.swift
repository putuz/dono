//
//  ScannerUnsupportedView.swift
//  Dono
//
//  Created by Bahtiar on 14/07/26.
//

import SwiftUI

struct ScannerUnsupportedView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "camera.metering.unknown")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            Text("Scanner tidak didukung di perangkat ini")
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
