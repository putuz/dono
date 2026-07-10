//
//  TabBarItem.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

// MARK: - Single tab bar item (icon + label)
struct TabBarItem: View {
    let tab: AppTab
    let isSelected: Bool
    var badge: Bool = false
 
    var body: some View {
        VStack(spacing: 4) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: tab.icon)
                    .font(.system(size: 22))
 
                if badge {
                    Image(systemName: "checkmark.shield.fill")
                        .font(.system(size: 12))
                        .foregroundStyle(.blue)
                        .background(
                            Circle().fill(.white).frame(width: 14, height: 14)
                        )
                        .offset(x: 6, y: -4)
                }
            }
            Text(tab.title)
                .fontWeight(.semibold)
                .font(.system(size: 13))
        }
        .foregroundStyle(isSelected ? .primary : .secondary)
        .frame(maxWidth: .infinity)
    }
}
