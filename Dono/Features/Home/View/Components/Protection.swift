//
//  Protection.swift
//  Dono
//
//  Created by Bahtiar on 11/07/26.
//

import SwiftUI

struct Protection: View {
    @State private var searchText: String = ""
 
    var body: some View {
        VStack(spacing: 12) {
 
            // MARK: - Top card (banner + search + protection row)
            VStack(spacing: 0) {
 
                // Blue "activities protected" banner
                HStack {
                    Image(systemName: "checkmark.shield.fill")
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
 
                    Text("2")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    +
                    Text(" activities protected!")
                        .foregroundStyle(.white)
 
                    Spacer()
 
                    Button {
                        //
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
                .padding()
                .background(Color.blue)
                .clipShape(
                    .rect(topLeadingRadius: 8, topTrailingRadius: 8)
                )
 
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.gray)
 
                    TextField("DANA CS offering help?", text: $searchText)
                        .foregroundStyle(.primary)
 
                    Spacer()
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
                .padding([.horizontal, .top])
 
                // DANA Protection row
                HStack {
                    HStack(spacing: 8) {
                        Image(systemName: "lock.fill")
                            .foregroundStyle(.blue)
                            .font(.system(size: 18))
 
                        Text("DANA\nPROTECTION")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.blue)
                            .lineSpacing(2)
                    }
 
                    Spacer()
 
                    HStack(spacing: 0) {
                        HStack(spacing: 4) {
                            Image(systemName: "shield.fill")
                                .foregroundStyle(.white)
                                .font(.system(size: 12))
                            Text("75%")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(Color.blue)
 
                        Button {
                            print("Upgrade Tapped")
                        } label: {
                            Text("UPGRADE")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(.blue)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                        }
                        .buttonStyle(.plain)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding()
            }
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(color: .black.opacity(0.15), radius: 4, y: 2)
        }
        .padding(.horizontal)
    }
}

#Preview {
    Protection()
}
