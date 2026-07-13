//
//  WalletView.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import SwiftUI

struct WalletView: View {
    private func refreshData() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
 
    var body: some View {
        VStack(spacing: 0) {
            StickyHeadWallet()
 
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Jarak kecil supaya "PAYMENT METHOD" tidak
                        // menempel persis di bawah search bar
                        Spacer().frame(height: 8)
 
                        PaymentMethodSection()
 
                        WalletEmptyDivider()
 
                        Spacer(minLength: 120)
 
                        Text("Version 2.133.1")
                            .foregroundStyle(.gray)
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                    }
                }
                .scrollIndicators(.never)
                .scrollContentBackground(.hidden)
                .refreshable {
                    await refreshData()
                }
                .onAppear {
                    UIRefreshControl.appearance().tintColor = .white
                }
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}
 
// MARK: - Model data untuk satu kartu pembayaran
struct PaymentCardModel: Identifiable {
    let id = UUID()
    let iconSystemName: String      // ikon di badge bulat kiri atas
    let issuerName: String          // contoh: "DANA", "BCA", "Mandiri"
    let cardNumber: String          // contoh: "•••• •••• •••• 4821"
    let description: String         // teks kecil di bawah nomor kartu
    let gradientColors: [Color]     // warna gradient header kartu
    let primaryActionTitle: String  // contoh: "OPEN"
}
 
// MARK: - Section "PAYMENT METHOD" (menampilkan banyak kartu)
struct PaymentMethodSection: View {
 
    // Data contoh untuk 3 kartu. Ganti/isi dari API atau state kamu sendiri.
    let cards: [PaymentCardModel] = [
        PaymentCardModel(
            iconSystemName: "flag.fill",
            issuerName: "DANA",
            cardNumber: "•••• •••• •••• 4821",
            description: "Saldo DANA kamu",
            gradientColors: [Color(red: 0.12, green: 0.42, blue: 0.95), Color(red: 0.35, green: 0.62, blue: 0.98)],
            primaryActionTitle: "OPEN"
        ),
        PaymentCardModel(
            iconSystemName: "building.columns.fill",
            issuerName: "BCA",
            cardNumber: "•••• •••• •••• 1190",
            description: "Kartu debit tersimpan",
            gradientColors: [Color(red: 0.85, green: 0.45, blue: 0.05), Color(red: 0.95, green: 0.62, blue: 0.25)],
            primaryActionTitle: "OPEN"
        ),
        PaymentCardModel(
            iconSystemName: "creditcard.fill",
            issuerName: "Mandiri",
            cardNumber: "•••• •••• •••• 7734",
            description: "Kartu kredit tersimpan",
            gradientColors: [Color(red: 0.95, green: 0.75, blue: 0.15), Color(red: 0.92, green: 0.55, blue: 0.1)],
            primaryActionTitle: "OPEN"
        )
    ]
 
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("PAYMENT METHOD")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.gray)
                Spacer()
                Text("\(cards.count) CARD")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)
            }
 
            StackedPaymentCards(cards: cards)
        }
        .padding(.horizontal, 20)
    }
}
 
// MARK: - Stack kartu yang bisa di-swipe untuk berganti kartu depan
struct StackedPaymentCards: View {
    @State private var cards: [PaymentCardModel]
    @State private var dragOffset: CGSize = .zero
 
    init(cards: [PaymentCardModel]) {
        _cards = State(initialValue: cards)
    }
 
    var body: some View {
        // alignment: .top supaya semua kartu rata di atas -> yang keliatan
        // "nongol" (peek) itu bagian BAWAH kartu di belakang
        ZStack(alignment: .top) {
            // enumerated() dari belakang ke depan supaya kartu index 0
            // (paling depan) digambar PALING TERAKHIR -> ada di paling atas
            ForEach(Array(cards.enumerated()).reversed(), id: \.element.id) { index, card in
                PaymentCardView(card: card)
                    // PENTING: lebar kartu belakang dibuat SAMA PERSIS dengan
                    // kartu depan (tidak di-scale) supaya tidak ada sisi kiri/kanan
                    // yang "nongol" tidak rapi di bagian atas. Peek yang kelihatan
                    // HANYA di bagian bawah, dari hasil offset ke bawah.
                    .overlay(
                        // Overlay gelap tipis supaya kartu di belakang terlihat
                        // "meresap"/menjauh, bukan transparan/hilang
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.black.opacity(darkenAmount(for: index)))
                    )
                    .scaleEffect(index == 0 ? 1 : 0.98, anchor: .top)
                    // Didorong ke bawah supaya bagian bawahnya nongol
                    // di belakang kartu depan
                    .offset(y: yOffset(for: index))
                    // Cuma kartu paling depan yang ikut gerak saat di-drag
                    .offset(index == 0 ? dragOffset : .zero)
                    .rotationEffect(
                        index == 0 ? .degrees(Double(dragOffset.width / 20)) : .degrees(0)
                    )
                    .zIndex(Double(cards.count - index))
                    .gesture(
                        index == 0 ? dragGesture : nil
                    )
            }
        }
        // .offset() tidak menambah ukuran ZStack secara otomatis, jadi kita
        // reserve ruang ekstra di bawah secara manual supaya kartu yang
        // nongol di belakang tidak terpotong oleh konten selanjutnya
        .padding(.bottom, CGFloat(max(cards.count, 1) - 1) * peekOffsetStep)
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: cards.map(\.id))
    }
 
    // Jarak vertikal antar lapisan kartu (semakin besar = semakin jelas peek-nya)
    private let peekOffsetStep: CGFloat = 16
 
    // Seberapa gelap overlay tiap lapis di belakang (0 = kartu depan, makin
    // besar makin gelap/menjauh -> memberi kesan "menonjol"/berlapis,
    // bukan makin transparan
    private func darkenAmount(for index: Int) -> Double {
        let cappedIndex = min(index, 2)
        return Double(cappedIndex) * 0.12
    }
 
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                dragOffset = value.translation
            }
            .onEnded { value in
                let threshold: CGFloat = 90
                if abs(value.translation.width) > threshold || abs(value.translation.height) > threshold {
                    // Kartu depan digeser cukup jauh -> pindahkan ke belakang stack
                    moveFrontCardToBack()
                }
                dragOffset = .zero
            }
    }
 
    private func moveFrontCardToBack() {
        guard !cards.isEmpty else { return }
        let front = cards.removeFirst()
        cards.append(front)
    }
 
    private func yOffset(for index: Int) -> CGFloat {
        let cappedIndex = min(index, 2)
        return CGFloat(cappedIndex) * peekOffsetStep
    }
}
 
// MARK: - Kartu pembayaran (reusable, dipakai untuk semua jenis kartu)
struct PaymentCardView: View {
    let card: PaymentCardModel
 
    var body: some View {
        VStack(spacing: 0) {
            // Bagian atas: gradient + nama issuer
            HStack(spacing: 10) {
                Circle()
                    .fill(Color.white)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Image(systemName: card.iconSystemName)
                            .font(.system(size: 13))
                            .foregroundColor(card.gradientColors.first ?? .blue)
                    )
 
                Text(card.issuerName.uppercased())
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                    .tracking(0.5)
 
                Spacer()
            }
            .padding(16)
            .background(
                LinearGradient(
                    colors: card.gradientColors,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
 
            // Bagian bawah: saldo + nomor kartu + deskripsi + aksi
            VStack(alignment: .leading, spacing: 12) {
                Text(card.cardNumber)
                    .padding(.vertical)
                    .font(.system(size: 14, weight: .medium, design: .monospaced))
                    .foregroundColor(.gray)
                    .tracking(1)
 
                Text(card.description)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
 
                HStack {
                    Button {
                        // aksi buka kartu
                    } label: {
                        Text(card.primaryActionTitle)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 18)
                            .padding(.vertical, 8)
                            .overlay(
                                Capsule().stroke(Color.gray.opacity(0.35), lineWidth: 1)
                            )
                    }
 
                    Spacer()
                }
            }
            .padding(16)
            .background(Color.white)
        }
        // Lapisan putih solid di paling belakang kartu, sebagai pengaman
        // supaya bagian manapun dari kartu ini TIDAK PERNAH tembus/transparan
        // ke kartu lain yang ada di belakangnya dalam stack
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
    }
}
 
// MARK: - Garis putus-putus bergelombang + watermark "WALLET"
struct WalletEmptyDivider: View {
    var body: some View {
        VStack(spacing: 20) {
            WaveDashedLine()
                .stroke(style: StrokeStyle(lineWidth: 1.2, dash: [4, 4]))
                .foregroundColor(.gray.opacity(0.35))
                .frame(height: 14)
                .padding(.horizontal, 20)
 
            HStack(spacing: 6) {
                WavyRibbonMark(size: 20)
 
                Text("WALLET")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray.opacity(0.45))
                    .tracking(1)
            }
        }
    }
}
 
// MARK: - Bentuk garis bergelombang untuk WalletEmptyDivider
struct WaveDashedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let midY = rect.midY
        let waveWidth: CGFloat = 30
        let amplitude: CGFloat = 8
 
        path.move(to: CGPoint(x: 0, y: midY))
 
        var x: CGFloat = 0
        var goingUp = true
        while x < rect.width {
            let nextX = min(x + waveWidth, rect.width)
            path.addQuadCurve(
                to: CGPoint(x: nextX, y: midY),
                control: CGPoint(x: x + waveWidth / 2, y: goingUp ? midY - amplitude : midY + amplitude)
            )
            goingUp.toggle()
            x = nextX
        }
 
        return path
    }
}


#Preview {
    WalletView()
}
