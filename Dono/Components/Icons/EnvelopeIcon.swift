//
//  EnvelopeIcon.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

// MARK: - Composed icon
struct EnvelopeIcon: View {
    var backgroundColor: Color = Color(red: 0.30, green: 0.60, blue: 0.92)
    var size: CGFloat = 96
 
    var body: some View {
        ZStack {
            RoundedSquareOutline(cornerRadius: size * 0.05)
                .stroke(Color.gray, lineWidth: size * 0.05)
                .frame(width: size * 0.62, height: size * 0.5)
 
            EnvelopeFlap()
                .stroke(Color.gray, style: StrokeStyle(
                    lineWidth: size * 0.07, lineCap: .round, lineJoin: .round
                ))
                .frame(width: size * 0.34, height: size * 0.16)
                .offset(y: -size * 0.02)
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    EnvelopeIcon(size: 120)
}
