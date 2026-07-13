//
//  Footer.swift
//  Dono
//
//  Created by Bahtiar on 11/07/26.
//

import SwiftUI

struct Footer: View {
    var body: some View {
        VStack {
            Text("DANA Indonesia terdaftar serta diawasi")
                .foregroundStyle(.gray)
            HStack {
                Text("oleh")
                    .foregroundStyle(.gray)
                Text("Bank Indonesia")
                    .fontWeight(.semibold)
                Text("dan")
                    .foregroundStyle(.gray)
                Text("Komdigi")
                    .fontWeight(.semibold)
            }
        }
        .font(.system(size: 14))
        .padding()
    }
}

#Preview {
    Footer()
}
