//
//  ContentView.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

// MARK: - Tab definition
enum AppTab: CaseIterable {
    case home
    case wallet
    case me
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .wallet: return "Wallet"
        case .me: return "Me"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house"
        case .wallet: return "wallet.pass"
        case .me: return "person.circle"
        }
    }
}

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
                .font(.system(size: 13))
        }
        .foregroundStyle(isSelected ? .primary : .secondary)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - The floating center "PAY" button
struct FloatingPayButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Image(systemName: "qrcode")
                    .font(.system(size: 26, weight: .medium))
                Text("PAY")
                    .font(.system(size: 13, weight: .semibold))
            }
            .foregroundStyle(.white)
            .frame(width: 76, height: 76)
            .background(Circle().fill(Color.blue))
            // Subtle ring/shadow to help it read as "floating" above the bar
            .shadow(color: .blue.opacity(0.35), radius: 10, y: 4)
        }
        // Pulls the button upward so it overlaps the top edge of the bar
        .offset(y: -28)
    }
}

// MARK: - Composed custom tab bar
struct CustomTabBar: View {
    @Binding var selectedTab: AppTab
    
    var onActivityTapped: () -> Void = {}
    var onPayTapped: () -> Void = {}
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color(.systemBackground)
                .frame(height: 64)
                .shadow(color: .black.opacity(0.06), radius: 6, y: -2)
            
            HStack(spacing: 0) {
                
                tabButton(.home)
                
                activityButton()
                
                Spacer()
                    .frame(maxWidth: .infinity)
                
                tabButton(.wallet)
                
                tabButton(.me, badge: true)
            }
            .padding(.top, 10)
            .frame(height: 64)
            
            FloatingPayButton(action: onPayTapped)
        }
    }
    
    private func activityButton() -> some View {
        Button {
            onActivityTapped()
        } label: {
            VStack(spacing: 4) {
                Image(systemName: "doc.text")
                    .font(.system(size: 22))
                
                Text("Activity")
                    .font(.system(size: 13))
            }
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
    
    private func tabButton(_ tab: AppTab, badge: Bool = false) -> some View {
        Button {
            selectedTab = tab
        } label: {
            TabBarItem(
                tab: tab,
                isSelected: selectedTab == tab,
                badge: badge
            )
        }
        .buttonStyle(.plain)
    }
}

struct ContentView: View {
    @State private var selectedTab: AppTab = .home
    @State private var showActivity = false
    @State private var showPaySheet = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Group {
                    switch selectedTab {
                    case .home:
                        HomeView()
                            .transition(
                                .move(edge: .leading)
                                .combined(with: .opacity)
                            )
                        
                    case .wallet:
                        WalletView()
                            .transition(
                                .move(edge: .trailing)
                                .combined(with: .opacity)
                            )
                        
                    case .me:
                        MeView()
                            .transition(
                                .move(edge: .trailing)
                                .combined(with: .opacity)
                            )
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .animation(
                    .easeInOut(duration: 0.25),
                    value: selectedTab
                )
                
                
                CustomTabBar(
                    selectedTab: $selectedTab,
                    onActivityTapped: {
                        showActivity = true
                    },
                    onPayTapped: {
                        showPaySheet = true
                    }
                )
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationDestination(isPresented: $showActivity) {
                ActivityView()
            }
        }
        .sheet(isPresented: $showPaySheet) {
            VStack {
                Text("Pay QR")
            }
            .presentationDetents([.medium])
        }
    }
}

#Preview {
    ContentView()
}
