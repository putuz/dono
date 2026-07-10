//
//  Carousel.swift
//  Dono
//
//  Created by Bahtiar on 10/07/26.
//

import SwiftUI

struct BannerItem: Identifiable {
    let id = UUID()
    let originalIndex: Int
    let imageName: String
}

struct Carousel: View {
    let images: [String]   // <-- terima nama asset dari luar
    private let multiplier = 20

    @State private var items: [BannerItem] = []
    @State private var current: UUID?
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geo in
            let cardWidth = geo.size.width * 0.80
            let sidePadding = (geo.size.width - cardWidth) / 2

            ZStack(alignment: .bottom) {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 12) {
                        ForEach(items) { item in
                            BannerCard(item: item)
                                .frame(width: cardWidth, height: 180)
                                .id(item.id)
                        }
                    }
                    .scrollTargetLayout()
                }
                .safeAreaPadding(.horizontal, sidePadding)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $current)
                .onAppear {
                    setupItems()
                    let middleIndex = items.count / 2
                    current = items[middleIndex].id
                }
                .onChange(of: current) { _, newValue in
                    checkAndResetIfNeeded(newValue: newValue)
                }
                .onReceive(timer) { _ in
                    scrollToNext()
                }

                dotIndicator
                    .padding(.bottom, 12)
            }
        }
        .frame(height: 180)
    }

    private var currentOriginalIndex: Int {
        guard let current, let item = items.first(where: { $0.id == current }) else { return 0 }
        return item.originalIndex
    }

    private var dotIndicator: some View {
        HStack(spacing: 6) {
            ForEach(0..<images.count, id: \.self) { index in
                Capsule()
                    .fill(index == currentOriginalIndex ? Color.blue : Color.white)
                    .frame(width: 6, height: 6)
                    .animation(.easeInOut(duration: 0.2), value: currentOriginalIndex)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
    }

    private func setupItems() {
        guard items.isEmpty else { return }
        var result: [BannerItem] = []
        for _ in 0..<multiplier {
            for (index, name) in images.enumerated() {
                result.append(BannerItem(originalIndex: index, imageName: name))
            }
        }
        items = result
    }

    private func scrollToNext() {
        guard let current,
              let currentIndex = items.firstIndex(where: { $0.id == current }) else { return }
        let nextIndex = currentIndex + 1
        guard nextIndex < items.count else { return }
        withAnimation(.easeInOut(duration: 0.4)) {
            self.current = items[nextIndex].id
        }
    }

    private func checkAndResetIfNeeded(newValue: UUID?) {
        guard let newValue,
              let currentIndex = items.firstIndex(where: { $0.id == newValue }) else { return }
        let bufferZone = images.count * 3
        if currentIndex < bufferZone || currentIndex > items.count - bufferZone {
            let originalIndex = items[currentIndex].originalIndex
            let middleSetStart = (items.count / 2) - ((items.count / 2) % images.count)
            let targetIndex = middleSetStart + originalIndex
            DispatchQueue.main.async {
                var transaction = Transaction()
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                    current = items[targetIndex].id
                }
            }
        }
    }
}

struct BannerCard: View {
    let item: BannerItem
    var body: some View {
        Image(item.imageName)
            .resizable()
            .scaledToFill()
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    Carousel(images: ["carouselHome1", "carouselHome2", "carouselHome3", "carouselHome4"])
}
