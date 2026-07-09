//
//  AppTab.swift
//  Dono
//
//  Created by Bahtiar on 09/07/26.
//

import Foundation

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
