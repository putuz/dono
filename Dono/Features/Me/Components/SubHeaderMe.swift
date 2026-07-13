//
//  SubHeaderMe.swift
//  Dono
//
//  Created by Bahtiar on 11/07/26.
//

import SwiftUI

struct SubHeaderMe: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 10) {
                // Avatar + Premium badge overlay
                ZStack(alignment: .bottomLeading) {
                    Circle()
                        .fill(Color.white.opacity(0.35))
                        .frame(width: 78, height: 78)
                        .overlay {
                            Image(systemName: "person.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(.white.opacity(0.85))
                        }
 
                    HStack(spacing: 4) {
                        WavyRibbonMark(badgeColor: .white, ribbonColor: .blue, size: 14)
 
                        Text("PREMIUM")
                            .font(.system(size: 10, weight: .heavy))
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.black.opacity(0.55))
                    )
                    .offset(y: 4)
                }
 
                // Name, phone number
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 4) {
                        Text("PUTUT YUSRI BAHTIAR")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(.white)
                            .lineLimit(1)
 
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.8))
                    }
 
                    Text("08••••••••80")
                        .font(.system(size: 14))
                        .foregroundStyle(.white.opacity(0.75))
                    
                    // Action pills: My QR / Xtra Protection
                    HStack(spacing: 8) {
                        Button {
                            print("My QR tapped")
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "qrcode")
                                    .font(.system(size: 13, weight: .semibold))
         
                                Text("My QR")
                                    .font(.system(size: 14))
         
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 10))
                            }
                            .foregroundStyle(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .stroke(Color.white.opacity(0.7), lineWidth: 1.2)
                            )
                        }
                        .buttonStyle(.plain)
         
                        Button {
                            print("Xtra Protection tapped")
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "exclamationmark.shield.fill")
                                    .font(.system(size: 13))
                                    .foregroundStyle(.red)
         
                                Text("Xtra Protection")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
         
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 10))
                                    .foregroundStyle(.white)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(Color.white.opacity(0.18))
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical)
        .background(Color.blue)
    }
}

#Preview {
    SubHeaderMe()
}
