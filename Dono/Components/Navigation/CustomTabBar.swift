//
//  CustomTabBar.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

// MARK: - Composed custom tab bar
struct CustomTabBar: View {
    @Binding var selectedTab: AppTab

    var onHomeTapped: () -> Void = {}
    var onActivityTapped: () -> Void = {}
    var onPayTapped: () -> Void = {}
 
    var body: some View {
        ZStack(alignment: .top) {

 
            HStack(spacing: 0) {
 
                homeButton()
 
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
 
    private func homeButton() -> some View {
        Button {
            selectedTab = .home
            onHomeTapped()
        } label: {
            TabBarItem(tab: .home, isSelected: selectedTab == .home)
        }
        .buttonStyle(.plain)
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

#Preview {
    PreviewContainer()
}

private struct PreviewContainer: View {

    @State private var selectedTab: AppTab = .home

    var body: some View {
        VStack {
            Spacer()

            CustomTabBar(
                selectedTab: $selectedTab,
                onHomeTapped: {
                    print("Home")
                },
                onActivityTapped: {
                    print("Activity")
                },
                onPayTapped: {
                    print("Pay")
                }
            )
        }
        .background(Color(.systemBackground))
    }
}
