//
//  PhotoPreviewView.swift
//  ImageTranslate
//
//  Created by Aaron Cleveland on 9/9/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import UIKit
import Photos

class PhotoPreviewView: UIView {

    let photoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy private var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    lazy private var savePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        button.addTarget(self, action: #selector(handleSavePhoto), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor,
                              left: leftAnchor,
                              bottom: bottomAnchor,
                              right: rightAnchor)
        
        addSubview(cancelButton)
        cancelButton.anchor(top: safeAreaLayoutGuide.topAnchor,
                            right: rightAnchor,
                            paddingTop: 15,
                            paddingRight: 10,
                            width: 50,
                            height: 50)
        
        addSubview(savePhotoButton)
        savePhotoButton.anchor(right: cancelButton.leftAnchor,
                               paddingRight: 5,
                               width: 50,
                               height: 50)
        savePhotoButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
    }
    
    // MARK: - Object Helpers
    
    @objc func handleCancel() {
        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
    }
    
    @objc func handleSavePhoto() {
        guard let previewImage = self.photoImageView.image else { return }
        PHPhotoLibrary.requestAuthorization { (status) in
            if status == .authorized {
                do {
                    try PHPhotoLibrary.shared().performChangesAndWait {
                        PHAssetChangeRequest.creationRequestForAsset(from: previewImage)
                        print("Photo has been saved to library")
                        self.handleCancel()
                    }
                } catch let error {
                    print("Failed to save photo in library: ", error)
                }
            } else {
                print("Something went wrong with permission.")
            }
        }
    }
}
