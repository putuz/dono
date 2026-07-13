//
//  stickyOptionHeader.swift
//  Dono
//
//  Created by Bahtiar on 11/07/26.
//

import SwiftUI

struct StickyOptionHeader: View {

    @State private var selected = "Personal"

    init() {
        let appearance = UISegmentedControl.appearance()

        appearance.selectedSegmentTintColor = .white
        appearance.backgroundColor = .blue

        appearance.setTitleTextAttributes([
            .foregroundColor: UIColor.white
        ], for: .normal)

        appearance.setTitleTextAttributes([
            .foregroundColor: UIColor.systemBlue
        ], for: .selected)
    }

    var body: some View {
        HStack {
            Spacer()
            
            Picker("", selection: $selected) {
                Text("Personal").tag("Personal")
                Text("Bisnis").tag("Bisnis")
            }
            .pickerStyle(.segmented)
            .frame(width: 180)

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical)
        .background(Color.blue)
    }
}

#Preview {
    StickyOptionHeader()
}
