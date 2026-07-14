//
//  ContentView.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: AppTab = .home
    @State private var showActivity = false
    @State private var showPaySheet = false
 
    /// Bumped whenever Home is tapped while already selected.
    /// HomeView watches this value and scrolls to top when it changes.
    @State private var homeScrollToTopTrigger = 0
 
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Group {
                    switch selectedTab {
                    case .home:
                        HomeView(scrollToTopTrigger: homeScrollToTopTrigger)
                            .transition(.move(edge: .leading).combined(with: .opacity))
 
                    case .wallet:
                        WalletView()
                            .transition(.move(edge: .trailing).combined(with: .opacity))
 
                    case .me:
                        MeView()
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .animation(.easeInOut(duration: 0.25), value: selectedTab)
 
                CustomTabBar(
                    selectedTab: $selectedTab,
                    onHomeTapped: {
                        if selectedTab == .home {
                            homeScrollToTopTrigger += 1
                        }
                    },
                    onActivityTapped: {
                        showActivity = true
                    },
                    onPayTapped: {
                        showPaySheet = true
                    }
                )
                .padding(.bottom)
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationDestination(isPresented: $showActivity) {
                ActivityView()
            }
        }
        .sheet(isPresented: $showPaySheet) {
            PayView()
                .presentationDetents([.medium])
        }
    }
}


#Preview {
    ContentView()
}
