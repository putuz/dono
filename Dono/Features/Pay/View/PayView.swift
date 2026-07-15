//
//  PayView.swift
//  Dono
//
//  Created by Bahtiar on 14/07/26.
//

import SwiftUI

struct PayView: View {
    @State private var scannedCode: String?
    @State private var isScanning = true
    @State private var isTorchOn = false
    @State private var scrolledPage: Int? = 0
    @StateObject private var permissionManager = CameraPermissionManager()
    
    var body: some View {
        content
            .navigationTitle("Pay")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: scrolledPage, handlePageChange)
            .onDisappear { isTorchOn = false }
            .onChange(of: scannedCode, handleScannedCodeChange)
    }
    
    @ViewBuilder
    private var content: some View {
        if !permissionManager.hasChecked {
            ProgressView()
                .onAppear(perform: permissionManager.checkPermission)
        } else if !permissionManager.isAuthorized {
            CameraPermissionDeniedView(onOpenSettings: permissionManager.openSettings)
        } else {
            pagerView
        }
    }
    
    private var pagerView: some View {
        VStack(spacing: 12) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 16) {
                    scannerPage
                        
                        .id(0)
                    
                    DanaBalanceView(qrisPayload: "00020101021126...dummy-qris-payload")
                        .frame(width: 280, height: 350)
                        .id(1)
                }
                .scrollTargetLayout()
            }
            .contentMargins(.horizontal, 20, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $scrolledPage)
            .scrollIndicators(.hidden)
        }
    }
    
    // Closure di-extract & di-type eksplisit biar compiler gak pusing
    private func pageWidth(_ length: CGFloat, _ axis: Axis) -> CGFloat {
        length * 0.90
    }
    
    private func handlePageChange(_ oldValue: Int?, _ newPage: Int?) {
        let page = newPage ?? 0
        isScanning = (page == 0)
        if page != 0 {
            isTorchOn = false
        }
    }
    
    private func handleScannedCodeChange(_ oldValue: String?, _ newValue: String?) {
        guard newValue != nil else { return }
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    
    private var scannerPage: some View {
        VStack {
            cameraBox
        }
        .overlay(alignment: .bottom) {
            ScanResultOverlay(scannedCode: scannedCode) {
                scannedCode = nil
                isScanning = true
            }
            .animation(.spring(response: 0.35, dampingFraction: 0.8), value: scannedCode)
        }
    }
    
    private var cameraBox: some View {
        VStack {
            QRISScannerView(
                scannedCode: $scannedCode,
                isScanning: $isScanning,
                isTorchOn: $isTorchOn
            )
            .overlay(alignment: .topTrailing) {
                torchButton
                    .padding()
            }
        }
        .frame(width: 280, height: 350)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    private var torchButton: some View {
        Button {
            isTorchOn.toggle()
        } label: {
            Image(systemName: isTorchOn ? "bolt.fill" : "bolt.slash.fill")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
        .disabled((scrolledPage ?? 0) != 0)
        .opacity((scrolledPage ?? 0) != 0 ? 0.4 : 1)
    }
}

#Preview {
    PayView()
}
