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
                                    EnvelopeIcon(size: 64, colorShape: .white ,colorFont: .white, iconSize: 12)
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
                        
                        SubHeader(items: [
                            SubHeaderItem(title: "iPhone 17", subtitle: "Siap Kamu Klaim"),
                            SubHeaderItem(title: "Beli VIP Pass", subtitle: "& Dapetin Hadiahnya")
                        ])

                        LazyVStack(spacing: 12) {
                            ForEach(0..<6, id: \.self) { i in
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.15))
                                    .frame(height: 200)
                                    .overlay(Text("Item \(i)"))
                                    .padding(.horizontal)
                                    .id(i)
                            }
                        }
                        .padding(.top, 12)
                        .background(Color.white)
                    }
                    .scrollIndicators(.never)
                    .scrollContentBackground(.hidden)
                    .refreshable(action: {
                        await refreshData()
                    })
                    .onAppear {
                        UIRefreshControl.appearance().tintColor  = .white
                    }
                    .onChange(of: scrollToTopTrigger) { _, _ in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            proxy.scrollTo(0, anchor: .top)
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
