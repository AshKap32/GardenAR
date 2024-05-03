//
//  ScanView.swift
//  GardenAR
//
//  Created by Rishi Jagtap on 5/2/24.
//

import AVFoundation
import SwiftUI

class ScanController: UIViewController {
    //capture Session
    var session: AVCaptureSession?
    
    //preview Video
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(previewLayer)
        checkCameraPermissions()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
    }
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case .notDetermined:
            //Request Permission
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self?.cameraSetUp()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            cameraSetUp()
        @unknown default:
            break
        }
    }
    
    private func cameraSetUp() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input){
                    session.addInput(input)
                }
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                
                session.startRunning()
                self.session = session
                
            }
            catch {
                print(error)
            }
        }
    }
    
    
}





