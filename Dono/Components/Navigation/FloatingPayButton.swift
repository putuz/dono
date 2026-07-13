//
//  FloatingPayButton.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

// MARK: - The floating center "PAY" button
struct FloatingPayButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Image(systemName: "qrcode")
                    .font(.system(size: 26, weight: .medium))

                Text("PAY")
                    .font(.system(size: 13, weight: .bold))
            }
            .foregroundStyle(.white)
            .frame(width: 76, height: 76)
            .background(
                Circle()
                    .fill(Color.blue)
            )
            .overlay(
                Circle()
                    .stroke(.white, lineWidth: 1)
            )
            .shadow(
                color: .black.opacity(0.18),
                radius: 10,
                y: 5
            )
        }
        .buttonStyle(.plain)
        .offset(y: -28)
    }
}

#Preview {
    FloatingPayButton(action: {})
}
