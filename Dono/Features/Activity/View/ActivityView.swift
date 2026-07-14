//
//  ActivityView.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

// MARK: - PreferenceKey untuk track posisi tiap section header
 
struct SectionOffsetKey: PreferenceKey {
    static var defaultValue: [String: CGFloat] = [:]
    static func reduce(value: inout [String: CGFloat], nextValue: () -> [String: CGFloat]) {
        value.merge(nextValue()) { _, new in new }
    }
}
 
// MARK: - SearchBar
 
struct SearchBar: View {
    
    @Binding var text: String
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.white.opacity(0.7))
            
            TextField(
                "",
                text: $text,
                prompt: Text("Search activity")
                    .foregroundStyle(.white.opacity(0.7))
            )
            .foregroundStyle(.white)
            .tint(.white)
            
            if !text.isEmpty {
                
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.white.opacity(0.7))
                }
                
            }
        }
        .padding(.horizontal, 14)
        .frame(height: 46)
        .background(Color.white.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(.blue)
    }
}
 
// MARK: - MonthSelector
 
struct MonthSelector: View {

    let months: [String]

    @Binding var selectedMonth: String

    var onSelect: ((String) -> Void)? = nil

    var body: some View {

        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 10) {

                    ForEach(months, id: \.self) { month in

                        Button {
                            selectedMonth = month
                            onSelect?(month)
                        } label: {

                            Text(month)
                                .font(.system(size: 15, weight: .medium))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 8)
                                .background(
                                    selectedMonth == month ?
                                    Color.blue.opacity(0.35) :
                                        Color.clear
                                )
                                .background(
                                    // outline tipis biar chip selected lebih "berbentuk"
                                    Capsule()
                                        .stroke(Color.white.opacity(selectedMonth == month ? 0.7 : 0), lineWidth: 1.5)
                                )
                                .clipShape(Capsule())
                        }
                        .id(month)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
            .background(Color.blue)
            .onAppear {
                proxy.scrollTo(selectedMonth, anchor: .trailing)
            }
            .onChange(of: selectedMonth) { _, newMonth in
                withAnimation {
                    proxy.scrollTo(newMonth, anchor: .center)
                }
            }
        }
    }
}
 
// MARK: - ActivitySection (Header per bulan)
 
struct ActivitySection: View {
 
    let title: String
 
    var body: some View {
 
        HStack {
 
            Text(title)
                .font(.title3.bold())
 
            Spacer()
 
        }
        .padding(.horizontal)
        .padding(.top, 20)
        .padding(.bottom, 10)
        .background(
            GeometryReader { geo in
                Color.clear
                    .preference(
                        key: SectionOffsetKey.self,
                        value: [title: geo.frame(in: .named("activityScroll")).minY]
                    )
            }
        )
    }
}
 
// MARK: - ActivityItem & Row
 
struct ActivityItem: Identifiable {
 
    let id = UUID()
 
    let title: String
    let subtitle: String
    let amount: String
    let icon: String
}
 
struct ActivityRow: View {
 
    let item: ActivityItem
 
    var body: some View {
 
        VStack(spacing: 0) {
            HStack(spacing: 14) {
 
                Circle()
                    .fill(Color.blue.opacity(0.12))
                    .frame(width: 48, height: 48)
                    .overlay {
 
                        Image(systemName: item.icon)
                            .foregroundStyle(.blue)
                    }
 
                VStack(alignment: .leading, spacing: 4) {
 
                    Text(item.title)
                        .font(.headline)
 
                    Text(item.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
 
                Spacer()
 
                Text(item.amount)
                    .font(.headline)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
 
            Divider()
                .padding(.leading, 76)
        }
    }
}
 
struct ActivitySectionData: Identifiable {
    let id = UUID()
    let month: String
    let items: [ActivityItem]
}
 
// MARK: - ActivityView
 
struct ActivityView: View {
 
    @State private var search = ""
 
    @State private var selectedMonth = "June 2026"
 
    /// Guard supaya tap-to-scroll nggak konflik dengan scroll-to-selectedMonth (anti infinite loop)
    @State private var isProgrammaticScroll = false
 
    // Urutan kiri -> kanan: paling lama -> paling baru
    let months = [
        "January 2026",
        "February 2026",
        "March 2026",
        "April 2026",
        "May 2026",
        "June 2026"
    ]
 
    let activitySections: [ActivitySectionData] = [
        ActivitySectionData(
            month: "June 2026",
            items: [
                ActivityItem(title: "Salary", subtitle: "30 Jun 2026 • 07:02", amount: "+Rp8.500.000", icon: "banknote.fill"),
                ActivityItem(title: "Netflix Subscription", subtitle: "29 Jun 2026 • 00:14", amount: "-Rp54.000", icon: "play.tv.fill"),
                ActivityItem(title: "Top Up", subtitle: "28 Jun 2026 • 09:15", amount: "+Rp500.000", icon: "plus.circle.fill"),
                ActivityItem(title: "Kopi Kenangan", subtitle: "28 Jun 2026 • 08:41", amount: "-Rp23.000", icon: "cup.and.saucer.fill"),
                ActivityItem(title: "Gojek Ride", subtitle: "27 Jun 2026 • 18:52", amount: "-Rp19.500", icon: "car.fill"),
                ActivityItem(title: "QR Payment - Indomaret", subtitle: "26 Jun 2026 • 12:30", amount: "-Rp47.200", icon: "qrcode"),
                ActivityItem(title: "Transfer to Dimas", subtitle: "25 Jun 2026 • 18:10", amount: "-Rp120.000", icon: "arrow.up.circle.fill"),
                ActivityItem(title: "Receive from Ayu", subtitle: "24 Jun 2026 • 15:22", amount: "+Rp80.000", icon: "arrow.down.circle.fill"),
                ActivityItem(title: "PLN - Token Listrik", subtitle: "22 Jun 2026 • 20:05", amount: "-Rp200.000", icon: "bolt.fill"),
                ActivityItem(title: "Pulsa Telkomsel", subtitle: "18 Jun 2026 • 10:10", amount: "-Rp50.000", icon: "iphone"),
                ActivityItem(title: "Tokopedia - Sepatu Lari", subtitle: "16 Jun 2026 • 21:37", amount: "-Rp389.000", icon: "bag.fill"),
                ActivityItem(title: "Cashback Promo", subtitle: "15 Jun 2026 • 13:00", amount: "+Rp12.500", icon: "gift.fill"),
                ActivityItem(title: "BPJS Kesehatan", subtitle: "10 Jun 2026 • 09:00", amount: "-Rp150.000", icon: "cross.case.fill"),
                ActivityItem(title: "Refund - Shopee", subtitle: "05 Jun 2026 • 16:45", amount: "+Rp75.000", icon: "arrow.uturn.left.circle.fill")
            ]
        ),
        ActivitySectionData(
            month: "May 2026",
            items: [
                ActivityItem(title: "Top Up", subtitle: "27 May 2026 • 08:00", amount: "+Rp300.000", icon: "plus.circle.fill"),
                ActivityItem(title: "Grab Food - Ayam Geprek", subtitle: "26 May 2026 • 12:20", amount: "-Rp34.500", icon: "bag.fill"),
                ActivityItem(title: "Transfer to Ibu", subtitle: "24 May 2026 • 14:12", amount: "-Rp500.000", icon: "arrow.up.circle.fill"),
                ActivityItem(title: "Spotify Premium", subtitle: "22 May 2026 • 00:03", amount: "-Rp64.900", icon: "music.note"),
                ActivityItem(title: "QR Payment - Alfamart", subtitle: "20 May 2026 • 19:20", amount: "-Rp15.000", icon: "qrcode"),
                ActivityItem(title: "IndiHome - Internet", subtitle: "16 May 2026 • 09:10", amount: "-Rp325.000", icon: "wifi"),
                ActivityItem(title: "Cashback", subtitle: "14 May 2026 • 13:40", amount: "+Rp25.000", icon: "gift.fill"),
                ActivityItem(title: "Bioskop - XXI", subtitle: "12 May 2026 • 19:30", amount: "-Rp90.000", icon: "film.fill"),
                ActivityItem(title: "Freelance Payment", subtitle: "09 May 2026 • 11:15", amount: "+Rp1.250.000", icon: "banknote.fill"),
                ActivityItem(title: "Gopay Later - Cicilan", subtitle: "05 May 2026 • 08:00", amount: "-Rp175.000", icon: "creditcard.fill"),
                ActivityItem(title: "Parkir Mall", subtitle: "03 May 2026 • 20:47", amount: "-Rp5.000", icon: "parkingsign.circle.fill")
            ]
        ),
        ActivitySectionData(
            month: "April 2026",
            items: [
                ActivityItem(title: "QR Payment - Warteg", subtitle: "29 Apr 2026 • 12:05", amount: "-Rp18.000", icon: "qrcode"),
                ActivityItem(title: "Top Up", subtitle: "26 Apr 2026 • 11:20", amount: "+Rp400.000", icon: "plus.circle.fill"),
                ActivityItem(title: "Transfer to Kos", subtitle: "25 Apr 2026 • 16:50", amount: "-Rp950.000", icon: "arrow.up.circle.fill"),
                ActivityItem(title: "Investasi - Reksadana", subtitle: "20 Apr 2026 • 10:00", amount: "-Rp500.000", icon: "chart.line.uptrend.xyaxis"),
                ActivityItem(title: "Movie - Cinepolis", subtitle: "18 Apr 2026 • 21:15", amount: "-Rp60.000", icon: "film.fill"),
                ActivityItem(title: "Receive from Client", subtitle: "15 Apr 2026 • 08:20", amount: "+Rp2.000.000", icon: "arrow.down.circle.fill"),
                ActivityItem(title: "Steam Wallet", subtitle: "12 Apr 2026 • 22:40", amount: "-Rp150.000", icon: "gamecontroller.fill"),
                ActivityItem(title: "Grab Ride", subtitle: "08 Apr 2026 • 07:55", amount: "-Rp28.000", icon: "car.fill"),
                ActivityItem(title: "THR Bonus", subtitle: "02 Apr 2026 • 09:00", amount: "+Rp1.500.000", icon: "gift.fill")
            ]
        ),
        ActivitySectionData(
            month: "March 2026",
            items: [
                ActivityItem(title: "Salary", subtitle: "31 Mar 2026 • 07:00", amount: "+Rp8.500.000", icon: "banknote.fill"),
                ActivityItem(title: "Zakat & Donasi", subtitle: "28 Mar 2026 • 18:30", amount: "-Rp250.000", icon: "heart.fill"),
                ActivityItem(title: "Buka Puasa Bersama", subtitle: "24 Mar 2026 • 17:45", amount: "-Rp135.000", icon: "fork.knife"),
                ActivityItem(title: "QR Payment - Minimarket", subtitle: "20 Mar 2026 • 20:10", amount: "-Rp42.300", icon: "qrcode"),
                ActivityItem(title: "Top Up", subtitle: "17 Mar 2026 • 09:45", amount: "+Rp250.000", icon: "plus.circle.fill"),
                ActivityItem(title: "Laundry", subtitle: "14 Mar 2026 • 15:00", amount: "-Rp35.000", icon: "washer.fill"),
                ActivityItem(title: "Transfer to Adik", subtitle: "10 Mar 2026 • 13:22", amount: "-Rp200.000", icon: "arrow.up.circle.fill"),
                ActivityItem(title: "Cashback Kartu Kredit", subtitle: "05 Mar 2026 • 09:00", amount: "+Rp18.000", icon: "gift.fill")
            ]
        ),
        ActivitySectionData(
            month: "February 2026",
            items: [
                ActivityItem(title: "Salary", subtitle: "28 Feb 2026 • 07:00", amount: "+Rp8.500.000", icon: "banknote.fill"),
                ActivityItem(title: "Valentine Dinner", subtitle: "14 Feb 2026 • 19:30", amount: "-Rp420.000", icon: "fork.knife"),
                ActivityItem(title: "QR Payment - Coffee Shop", subtitle: "12 Feb 2026 • 08:15", amount: "-Rp29.000", icon: "qrcode"),
                ActivityItem(title: "Asuransi Kesehatan", subtitle: "10 Feb 2026 • 09:00", amount: "-Rp180.000", icon: "cross.case.fill"),
                ActivityItem(title: "Top Up", subtitle: "07 Feb 2026 • 10:30", amount: "+Rp300.000", icon: "plus.circle.fill"),
                ActivityItem(title: "Receive from Ayu", subtitle: "03 Feb 2026 • 14:00", amount: "+Rp95.000", icon: "arrow.down.circle.fill"),
                ActivityItem(title: "Grab Food", subtitle: "01 Feb 2026 • 12:40", amount: "-Rp38.000", icon: "bag.fill")
            ]
        ),
        ActivitySectionData(
            month: "January 2026",
            items: [
                ActivityItem(title: "Salary", subtitle: "31 Jan 2026 • 07:00", amount: "+Rp8.500.000", icon: "banknote.fill"),
                ActivityItem(title: "Tahun Baru - Kembang Api", subtitle: "01 Jan 2026 • 00:30", amount: "-Rp75.000", icon: "sparkles"),
                ActivityItem(title: "Top Up", subtitle: "28 Jan 2026 • 08:20", amount: "+Rp350.000", icon: "plus.circle.fill"),
                ActivityItem(title: "Gym Membership", subtitle: "20 Jan 2026 • 06:45", amount: "-Rp300.000", icon: "figure.run"),
                ActivityItem(title: "QR Payment - Apotek", subtitle: "15 Jan 2026 • 17:10", amount: "-Rp62.000", icon: "qrcode"),
                ActivityItem(title: "Transfer to Teman", subtitle: "10 Jan 2026 • 20:00", amount: "-Rp100.000", icon: "arrow.up.circle.fill"),
                ActivityItem(title: "Bonus Akhir Tahun", subtitle: "02 Jan 2026 • 09:00", amount: "+Rp2.000.000", icon: "gift.fill")
            ]
        )
    ]
 
    var body: some View {
 
        VStack(spacing: 0) {
 
            StickyHeadActivity()
 
            SearchBar(text: $search)
 
            MonthSelector(
                months: months,
                selectedMonth: $selectedMonth,
                onSelect: { month in
                    scrollToMonth(month)
                }
            )
 
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                        ForEach(activitySections) { section in
                            Section {
                                ForEach(section.items) { item in
                                    ActivityRow(item: item)
                                }
                            } header: {
                                ActivitySection(title: section.month)
                                    .id(section.month)
                                    .frame(maxWidth: .infinity)
                                    .background(.background)
                            }
                        }
                    }
                }
                .scrollIndicators(.never)
                .coordinateSpace(name: "activityScroll")
                .onPreferenceChange(SectionOffsetKey.self) { offsets in
                    // Kalau lagi scroll gara-gara tap (programmatic), jangan override selectedMonth
                    guard !isProgrammaticScroll else { return }
                    updateSelectedMonth(from: offsets)
                }
                .onChange(of: selectedMonth) { _, _ in
                    // reserved kalau butuh reaksi lain saat selectedMonth berubah
                }
                .background(
                    // simpan proxy lewat closure supaya bisa dipanggil dari scrollToMonth
                    ScrollProxyHolder(proxy: proxy, holder: scrollProxyBox)
                )
            }
        }
    }
 
    // Box buat nyimpen ScrollViewProxy supaya bisa diakses dari fungsi lain
    private let scrollProxyBox = ScrollProxyBox()
 
    private func scrollToMonth(_ month: String) {
        isProgrammaticScroll = true
        withAnimation {
            scrollProxyBox.proxy?.scrollTo(month, anchor: .top)
        }
        // Kasih jeda sebelum re-enable auto-sync, biar animasi scroll selesai dulu
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            isProgrammaticScroll = false
        }
    }
 
    private func updateSelectedMonth(from offsets: [String: CGFloat]) {
        // Threshold: kira-kira tinggi pinned header. Sesuaikan sesuai desain kamu.
        let threshold: CGFloat = 44
 
        // Ambil section yang sudah lewat/sejajar threshold,
        // pilih yang paling "terbaru" (minY paling besar di antara yang <= threshold)
        let passed = offsets.filter { $0.value <= threshold }
 
        if let active = passed.max(by: { $0.value < $1.value })?.key {
            if selectedMonth != active {
                selectedMonth = active
            }
        }
    }
}
 
// MARK: - Helper untuk expose ScrollViewProxy ke fungsi luar body
 
final class ScrollProxyBox {
    var proxy: ScrollViewProxy?
}
 
struct ScrollProxyHolder: View {
    let proxy: ScrollViewProxy
    let holder: ScrollProxyBox
 
    var body: some View {
        Color.clear
            .onAppear { holder.proxy = proxy }
    }
}

#Preview {
    ActivityView()
}
