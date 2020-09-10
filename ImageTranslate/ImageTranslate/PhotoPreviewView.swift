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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoImageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
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
