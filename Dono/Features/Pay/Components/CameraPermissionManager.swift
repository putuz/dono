//
//  CameraPermissionManager.swift
//  Dono
//
//  Created by Bahtiar on 14/07/26.
//

import SwiftUI
import AVFoundation
 
/// Mengelola status izin kamera secara terpisah dari View,
/// supaya PayView tidak perlu tahu detail AVFoundation.
final class CameraPermissionManager: ObservableObject {
    @Published var isAuthorized = false
    @Published var hasChecked = false
 
    func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            isAuthorized = true
            hasChecked = true
 
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    self?.isAuthorized = granted
                    self?.hasChecked = true
                }
            }
 
        default:
            isAuthorized = false
            hasChecked = true
        }
    }
 
    func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}
