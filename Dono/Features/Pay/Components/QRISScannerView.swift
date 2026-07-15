//
//  QRISScannerView.swift
//  Dono
//
//  Created by Bahtiar on 14/07/26.
//

import SwiftUI
import AVFoundation
 
/// Bridge SwiftUI <-> UIKit scanner custom (AVFoundation).
/// Kita pegang sendiri AVCaptureSession-nya (bukan lewat VisionKit),
/// supaya toggle torch gak pernah bikin sesi kamera freeze/interrupt.
struct QRISScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode: String?
    @Binding var isScanning: Bool
    @Binding var isTorchOn: Bool
 
    func makeUIViewController(context: Context) -> ScannerViewController {
        let vc = ScannerViewController()
        vc.onCodeScanned = { code in
            scannedCode = code
            isScanning = false
        }
        return vc
    }
 
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {
        if isScanning {
            uiViewController.startScanning()
        } else {
            uiViewController.stopScanning()
        }
        uiViewController.setTorch(on: isTorchOn)
    }
}

#Preview {
    QRISScannerView(scannedCode: .constant(nil), isScanning: .constant(true), isTorchOn: .constant(false))
}
