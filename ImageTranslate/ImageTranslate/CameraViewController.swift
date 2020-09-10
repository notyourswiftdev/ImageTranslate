//
//  ViewController.swift
//  ImageTranslate
//
//  Created by Aaron Cleveland on 9/3/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import Foundation
import UIKit
import Photos

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    // MARK: - Properties
    private let photoOutput = AVCapturePhotoOutput()
    
    lazy private var takePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CAPTURE", for: .normal)
        button.setTitleColor(.label, for: .normal)
//        button.setImage(UIImage(systemName: "person")?.withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(handleTakePhoto), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        requestPermissionAndShowCamera()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.addSubview(takePhotoButton)
        takePhotoButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                               paddingBottom: 15,
                               width: 80,
                               height: 80)
        takePhotoButton.centerX(inView: view)
    }
    
    private func requestPermissionAndShowCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // User has already authorized to access the camera.
            self.setupCaptureSession()
        case .notDetermined: // user has not yet been asked for camera access
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if granted { // user has granted access to the camera
                    print("User has grated access to the camera")
                    DispatchQueue.main.async {
                        self.setupCaptureSession()
                    }
                } else {
                    print("User has not granted to access the camera")
                    self.handleDismiss()
                }
            }
        case .denied:
            print("User has denied previously to access the camera")
            self.handleDismiss()
        case .restricted:
            print("User can't give camera access due to some restrictions")
            self.handleDismiss()
        default:
            print("Something has gone wrong due to we can't access the camera.")
            self.handleDismiss()
        }
    }
    
    private func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        if let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) {
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                }
            } catch let error {
                print("Failed to set input device with error: \(error)")
            }
            
            if captureSession.canAddOutput(photoOutput) {
                captureSession.addOutput(photoOutput)
            }
            
            let cameraLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            cameraLayer.frame = self.view.frame
            cameraLayer.videoGravity = .resizeAspectFill
            self.view.layer.addSublayer(cameraLayer)
            captureSession.startRunning()
            self.setupUI()
        }
    }
    
    @objc func handleDismiss() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleTakePhoto() {
        let photoSettings = AVCapturePhotoSettings()
        if let photoPreviewType = photoSettings.availablePreviewPhotoPixelFormatTypes.first {
            photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: photoPreviewType]
            photoOutput.capturePhoto(with: photoSettings, delegate: self)
        }
    }
    
    internal func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        let previewImage = UIImage(data: imageData)
        
        let photoPreviewContainer = PhotoPreviewView(frame: self.view.frame)
        photoPreviewContainer.photoImageView.image = previewImage
        self.view.addSubview(photoPreviewContainer)
    }
}

