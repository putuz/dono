//
//  Header.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

struct Header: View {
    @Environment(\.colorScheme) private var colorScheme
    var body: some View {
        WavyRibbonMark(badgeColor: colorScheme == .dark ? .white : .blue, ribbonColor: colorScheme == .dark ? .blue : .white, size: 80)
        TopUpIcon(size: 120)
        RequestIcon(size: 120)
        SendIcon(size: 120)
        EnvelopeIcon(size: 120)
    }
}

#Preview {
    Header()
        .preferredColorScheme(.dark)
}
