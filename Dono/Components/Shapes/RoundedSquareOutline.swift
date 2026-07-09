//
//  RoundedSquareOutline.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

// MARK: - 1. The rounded square outline (envelope body)
struct RoundedSquareOutline: Shape {
    var cornerRadius: CGFloat = 14
 
    func path(in rect: CGRect) -> Path {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .path(in: rect)
    }
}
