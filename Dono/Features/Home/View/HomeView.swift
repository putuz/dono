//
//  HomeView.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

struct HomeView: View {
    var scrollToTopTrigger: Int = 0
 
    private func refreshData() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
 
    var body: some View {
        VStack(spacing: 0) {
            StickyBalanceHeader()
 
            ZStack(alignment: .top) {
                Color.blue
                    .frame(height: 400)
                    .ignoresSafeArea(edges: .top)
 
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 0) {
                            Color.clear
                                .frame(height: 0)
                                .id("top")
 
                            HStack(spacing: 30) {
                                Button {
                                    print("Top Up Tapped")
                                } label: {
                                    VStack(alignment: .center, spacing: 0) {
                                        TopUpIcon(size: 64, colorShape: .white, colorPlus: .white)
                                        Text("Top Up")
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                            .font(.caption)
                                    }
                                }
                                .buttonStyle(.plain)
 
                                Button {
                                    print("Request Tapped")
                                } label: {
                                    VStack(alignment: .center, spacing: 0) {
                                        RequestIcon(size: 64, colorShape: .white, colorFont: .white, iconSize: 12)
                                        Text("Request")
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                            .font(.caption)
                                    }
                                }
                                .buttonStyle(.plain)
 
                                Button {
                                    print("Send Tapped")
                                } label: {
                                    VStack(alignment: .center, spacing: 0) {
                                        SendIcon(size: 64, colorShape: .white, iconSize: 12)
                                        Text("Send")
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                            .font(.caption)
                                    }
                                }
                                .buttonStyle(.plain)
 
                                Button {
                                    print("Inbox Tapped")
                                } label: {
                                    VStack(alignment: .center, spacing: 0) {
                                        EnvelopeIcon(size: 64, colorShape: .white, colorFont: .white, iconSize: 12)
                                        Text("Inbox")
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                            .font(.caption)
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
 
                            SubHeaderHome(items: [
                                SubHeaderItem(title: "iPhone 17", subtitle: "Siap Kamu Klaim"),
                                SubHeaderItem(title: "Beli VIP Pass", subtitle: "& Dapetin Hadiahnya")
                            ])
                            .padding(.bottom, 10)
 
                            LazyVStack(spacing: 12) {
                                MenuGrid(items: [
                                    MenuItem(icon: "gift.fill", label: "Daily Rewards", onTap: { print("Daily Rewards") }),
                                    MenuItem(icon: "circle.hexagonpath.fill", label: "DANA Points", onTap: { print("DANA Points") }),
                                    MenuItem(icon: "gift.circle.fill", label: "Redeem Rewards", onTap: { print("Redeem Rewards") }),
                                    MenuItem(icon: "apple.logo", label: "Apple Zone", onTap: { print("Apple Zone") }),
                                    MenuItem(icon: "creditcard.fill", label: "Pulsa & Data", onTap: { print("Pulsa & Data") }),
                                    MenuItem(icon: "bolt.fill", label: "Electricity", onTap: { print("Electricity") }),
                                    MenuItem(icon: "star.circle.fill", label: "A+ Rewards", onTap: { print("A+ Rewards") }),
                                    MenuItem(icon: "square.grid.2x2.fill", label: "View All", onTap: { print("View All") })
                                ])
 
                                Feed(items: [
                                    FeedItem(
                                        brand: "DANA",
                                        text: "backs a team at ⚽️",
                                        emoji: nil,
                                        linkText: "Festival Bola Dunia",
                                        onTapLink: { print("Festival Bola Dunia tapped") }
                                    ),
                                    FeedItem(
                                        brand: "DANA",
                                        text: "Play",
                                        emoji: "🕹️",
                                        linkText: "Joy Games for Double Beans",
                                        onTapLink: { print("Joy Games tapped") }
                                    ),
                                    FeedItem(
                                        brand: "DANA",
                                        text: "Play",
                                        emoji: "🕹️",
                                        linkText: "Joy Games for Double Beans",
                                        onTapLink: { print("Joy Games tapped") }
                                    ),
                                    FeedItem(
                                        brand: "DANA",
                                        text: "Play",
                                        emoji: "🕹️",
                                        linkText: "Joy Games for Double Beans",
                                        onTapLink: { print("Joy Games tapped") }
                                    )
                                ])
 
                                Carousel(images: ["carouselHome1", "carouselHome2", "carouselHome3", "carouselHome4"])
 
                                Protection()
 
                                DanaDeals()
 
                                WhatNews()
 
                                Footer()
                            }
                            .padding(.vertical)
                            .background(Color.white)
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
                    .onChange(of: scrollToTopTrigger) { _, _ in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            proxy.scrollTo("top", anchor: .top)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
