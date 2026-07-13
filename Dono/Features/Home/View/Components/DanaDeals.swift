//
//  DanaDeals.swift
//  Dono
//
//  Created by Bahtiar on 11/07/26.
//

import SwiftUI

struct Voucher: Identifiable {
    let id = UUID()
    let logoText: String
    let logoBackground: Color
    let ticketColor: Color
    let title: String
    let price: String
    let subtitle: String
    let quantity: String?
    let discount: String
    let dealPrice: String
    let distance: String
}
 
// MARK: - Ticket shapes
 
/// Plain rounded-rect outline used to clip the whole card.
struct TicketOutline: Shape {
    var cornerRadius: CGFloat
 
    func path(in rect: CGRect) -> Path {
        Path(roundedRect: rect, cornerRadius: cornerRadius)
    }
}
 
/// Rounded-rect card outline with two semicircular "bites" cut out of the
/// top and bottom edges at `dividerX` — the classic ticket-stub notch.
/// Uses an even-odd fill: the rect is filled, then the two circles are
/// subtracted from it, leaving actual holes at the edges.
struct TicketShape: Shape {
    var cornerRadius: CGFloat
    var dividerX: CGFloat
    var notchRadius: CGFloat = 8
 
    func path(in rect: CGRect) -> Path {
        var path = Path(roundedRect: rect, cornerRadius: cornerRadius)
 
        // Top notch
        path.addEllipse(in: CGRect(
            x: dividerX - notchRadius,
            y: rect.minY - notchRadius,
            width: notchRadius * 2,
            height: notchRadius * 2
        ))
 
        // Bottom notch
        path.addEllipse(in: CGRect(
            x: dividerX - notchRadius,
            y: rect.maxY - notchRadius,
            width: notchRadius * 2,
            height: notchRadius * 2
        ))
 
        return path
    }
}
 
/// A single vertical line at `dividerX`, meant to be stroked with a dashed
/// `StrokeStyle` to create the perforated dashed divider between the notches.
struct TicketDivider: Shape {
    var dividerX: CGFloat
 
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: dividerX, y: rect.minY))
        path.addLine(to: CGPoint(x: dividerX, y: rect.maxY))
        return path
    }
}
 
// MARK: - Single voucher card
 
struct VoucherCardView: View {
    let voucher: Voucher
 
    private let leftWidth: CGFloat = 170
    private let rightWidth: CGFloat = 110
    private let cardHeight: CGFloat = 110
    private let cornerRadius: CGFloat = 10
 
    private var totalWidth: CGFloat { leftWidth + rightWidth }
 
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
 
                // Left colored ticket half
                HStack(spacing: 10) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Text(voucher.logoText)
                                .font(.system(size: 9, weight: .semibold))
                                .foregroundStyle(voucher.logoBackground)
                                .multilineTextAlignment(.center)
                        }
 
                    VStack(alignment: .leading, spacing: 2) {
                        Text(voucher.title)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.white)
                            .lineLimit(1)
 
                        Text(voucher.price)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(.white)
 
                        Text(voucher.subtitle)
                            .font(.system(size: 11))
                            .foregroundStyle(.white.opacity(0.9))
 
                        if let quantity = voucher.quantity {
                            HStack(spacing: 3) {
                                Image(systemName: "ticket.fill")
                                    .font(.system(size: 9))
                                Text(quantity)
                                    .font(.system(size: 10, weight: .semibold))
                            }
                            .foregroundStyle(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.blue)
                            .clipShape(Capsule())
                        }
                    }
 
                    Spacer(minLength: 0)
                }
                .padding(12)
                .frame(width: leftWidth, height: cardHeight, alignment: .leading)
                .background(voucher.ticketColor)
                .overlay(alignment: .topTrailing) {
                    Text(voucher.discount)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.green)
                        .clipShape(RibbonShape())
                }
 
                // Right price / distance half
                VStack(alignment: .leading, spacing: 6) {
                    Text(voucher.dealPrice)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.blue)
 
                    HStack(spacing: 3) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 11))
                            .foregroundStyle(.red)
                        Text(voucher.distance)
                            .font(.system(size: 12))
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal, 12)
                .frame(width: rightWidth, height: cardHeight, alignment: .leading)
                .background(Color(.systemBackground))
            }
        }
        .frame(width: totalWidth, height: cardHeight)
        .overlay(
            // Dashed perforation line between the two ticket halves
            TicketDivider(dividerX: leftWidth)
                .stroke(
                    Color(.white),
                    style: StrokeStyle(lineWidth: 1.5, dash: [4, 4])
                )
        )
        .clipShape(
            TicketShape(cornerRadius: cornerRadius, dividerX: leftWidth),
            style: FillStyle(eoFill: true)
        )
        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
    }
}
 
// Little pointed flag shape for the discount badge
struct RibbonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let notch: CGFloat = 6
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - notch))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
 
// MARK: - DANA Deals section
 
struct DanaDeals: View {
    let vouchers: [Voucher] = [
        Voucher(
            logoText: "SUPER",
            logoBackground: .red,
            ticketColor: .red,
            title: "Voucher Pa...",
            price: "Rp10.000",
            subtitle: "Shopping Voucher",
            quantity: "x2",
            discount: "-20%",
            dealPrice: "Rp8.000",
            distance: "1.2 km"
        ),
        Voucher(
            logoText: "MR.DIY",
            logoBackground: .orange,
            ticketColor: .yellow,
            title: "MR DIY Vou...",
            price: "Rp25.000",
            subtitle: "Shopping Voucher",
            quantity: nil,
            discount: "-20%",
            dealPrice: "Rp20.000",
            distance: "1.7 km"
        ),
        Voucher(
            logoText: "D'COST",
            logoBackground: .blue,
            ticketColor: .blue,
            title: "D'Cost Vou...",
            price: "Rp15.000",
            subtitle: "Dining Voucher",
            quantity: "x3",
            discount: "-15%",
            dealPrice: "Rp12.750",
            distance: "0.8 km"
        ),
        Voucher(
            logoText: "SECURE",
            logoBackground: .cyan,
            ticketColor: .cyan,
            title: "Secure Parking",
            price: "Rp5.000",
            subtitle: "Parking Voucher",
            quantity: "x1",
            discount: "-10%",
            dealPrice: "Rp4.500",
            distance: "0.3 km"
        ),
        Voucher(
            logoText: "ALFA",
            logoBackground: .green,
            ticketColor: .green,
            title: "Alfamart Vou...",
            price: "Rp20.000",
            subtitle: "Shopping Voucher",
            quantity: "x2",
            discount: "-25%",
            dealPrice: "Rp15.000",
            distance: "0.5 km"
        ),
        Voucher(
            logoText: "KFC",
            logoBackground: .red,
            ticketColor: .red,
            title: "KFC Meal Vou...",
            price: "Rp30.000",
            subtitle: "Dining Voucher",
            quantity: nil,
            discount: "-20%",
            dealPrice: "Rp24.000",
            distance: "1.5 km"
        ),
        Voucher(
            logoText: "INDOMARET",
            logoBackground: .blue,
            ticketColor: .indigo,
            title: "Indomaret Vou...",
            price: "Rp18.000",
            subtitle: "Shopping Voucher",
            quantity: "x2",
            discount: "-15%",
            dealPrice: "Rp15.300",
            distance: "0.6 km"
        ),
        Voucher(
            logoText: "PERTAMINA",
            logoBackground: .red,
            ticketColor: .teal,
            title: "Pertamina Fuel",
            price: "Rp50.000",
            subtitle: "Fuel Voucher",
            quantity: nil,
            discount: "-10%",
            dealPrice: "Rp45.000",
            distance: "2.1 km"
        ),
        Voucher(
            logoText: "STARBUCKS",
            logoBackground: .green,
            ticketColor: .brown,
            title: "Starbucks Vou...",
            price: "Rp35.000",
            subtitle: "Dining Voucher",
            quantity: "x1",
            discount: "-20%",
            dealPrice: "Rp28.000",
            distance: "1.0 km"
        ),
        Voucher(
            logoText: "GRAB",
            logoBackground: .green,
            ticketColor: .mint,
            title: "Grab Ride Vou...",
            price: "Rp12.000",
            subtitle: "Transport Voucher",
            quantity: "x4",
            discount: "-30%",
            dealPrice: "Rp8.400",
            distance: "0.1 km"
        )
    ]
 
    /// Two fixed-height rows so the grid scrolls horizontally in a 2xN layout,
    /// matching the DANA Deals section shown in the app.
    private let rows = [
        GridItem(.fixed(110), spacing: 10),
        GridItem(.fixed(110), spacing: 10)
    ]
 
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("DANA Deals")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
 
                    Text("Best vouchers around your area!")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
 
                Spacer()
 
                Button {
                    print("Explore Tapped")
                } label: {
                    Text("EXPLORE")
                        .font(.caption)
                        .foregroundStyle(.blue)
                        .frame(height: 40)
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                }
            }
 
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 10) {
                    ForEach(vouchers) { voucher in
                        VoucherCardView(voucher: voucher)
                            .padding(.bottom, 10)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .black.opacity(0.25), radius: 4, y: 2)
        .padding(.horizontal)
        
    }
}


#Preview {
    DanaDeals()
}
