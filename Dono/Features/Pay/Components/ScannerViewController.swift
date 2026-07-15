//
//  ScannerViewController.swift
//  Dono
//
//  Created by Bahtiar on 15/07/26.
//

import SwiftUI
import AVFoundation
 
/// UIViewController custom yang pegang AVCaptureSession sendiri.
/// Karena kita yang bikin & kontrol session-nya (bukan lewat VisionKit),
/// perubahan torch mode aman dilakukan kapan pun tanpa menghentikan preview.
final class ScannerViewController: UIViewController {
    var onCodeScanned: ((String) -> Void)?
 
    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "qris.scanner.session.queue")
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var videoDevice: AVCaptureDevice?
    private var hasScannedOnce = false
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupCamera()
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = view.bounds
    }
 
    // MARK: - Setup
 
    private func setupCamera() {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            return
        }
        videoDevice = device
 
        guard let input = try? AVCaptureDeviceInput(device: device) else { return }
 
        captureSession.beginConfiguration()
 
        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
        }
 
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: .main)
            metadataOutput.metadataObjectTypes = [.qr]
        }
 
        captureSession.commitConfiguration()
 
        let layer = AVCaptureVideoPreviewLayer(session: captureSession)
        layer.videoGravity = .resizeAspectFill
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
        previewLayer = layer
 
        startScanning()
    }
 
    // MARK: - Scanning control
 
    func startScanning() {
        hasScannedOnce = false
        // Tampilkan lagi preview-nya (langsung, gak nunggu session beneran jalan)
        previewLayer?.isHidden = false
        sessionQueue.async { [weak self] in
            guard let self, !self.captureSession.isRunning else { return }
            self.captureSession.startRunning()
        }
    }
 
    func stopScanning() {
        // Sembunyikan preview dulu supaya yang keliatan langsung hitam
        // (backgroundColor view), bukan frame terakhir yang membeku.
        previewLayer?.isHidden = true
        sessionQueue.async { [weak self] in
            guard let self, self.captureSession.isRunning else { return }
            self.captureSession.stopRunning()
        }
    }
 
    // MARK: - Torch control
 
    /// Aman dipanggil kapan pun, termasuk saat session sedang berjalan,
    /// karena videoDevice ini adalah device yang sama persis dengan
    /// yang jadi input session kita sendiri.
    func setTorch(on: Bool) {
        guard let device = videoDevice, device.hasTorch else { return }
        guard device.torchMode != (on ? .on : .off) else { return }
 
        do {
            try device.lockForConfiguration()
            device.torchMode = on ? .on : .off
            device.unlockForConfiguration()
        } catch {
            print("Gagal mengatur torch: \(error)")
        }
    }
 
    var isTorchAvailable: Bool {
        videoDevice?.hasTorch ?? false
    }
 
    deinit {
        if videoDevice?.hasTorch == true {
            try? videoDevice?.lockForConfiguration()
            videoDevice?.torchMode = .off
            videoDevice?.unlockForConfiguration()
        }
    }
}
 
// MARK: - AVCaptureMetadataOutputObjectsDelegate
 
extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        guard !hasScannedOnce,
              let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              object.type == .qr,
              let stringValue = object.stringValue else { return }
 
        hasScannedOnce = true
        onCodeScanned?(stringValue)
    }
}

