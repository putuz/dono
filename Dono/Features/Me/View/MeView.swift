//
//  MeView.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

struct MeView: View {
    private func refreshData() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
 
    var body: some View {
        VStack(spacing: 0) {
            StickyOptionHeader()
 
            ZStack(alignment: .top) {
                Color.blue
                    .frame(height: 300)
                    .ignoresSafeArea(edges: .top)
 
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 0) {
                            Color.clear
                                .frame(height: 0)
                                .id("top")
 
                            SubHeaderMe()
 
                            MenuGridMe()
                                .padding(.bottom, 10)
 
                            LazyVStack(spacing: 12) {
                                
                                SettingListMe()
 
                                Text("Version 2.133.1")
                                    .foregroundStyle(.gray)
                                    .font(.caption)
                            }
                        }
                    }
                    .scrollIndicators(.never)
                    .scrollContentBackground(.hidden)
                    .refreshable(action: {
                        await refreshData()
                    })
                    .onAppear {
                        UIRefreshControl.appearance().tintColor = .white
                    }
                }
            }
        }
    }
}
 



#Preview {
    MeView()
}
