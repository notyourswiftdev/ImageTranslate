//
//  HomeController.swift
//  ImageTranslate
//
//  Created by Aaron Cleveland on 9/9/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController {
    
    let takePhotoButton: UIButton = {
        let takePhotoButton = UIButton(type: .system)
        takePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        takePhotoButton.setTitle("Take Photo", for: .normal)
        takePhotoButton.setTitleColor(.white, for: .normal)
        takePhotoButton.backgroundColor = UIColor.gray
        takePhotoButton.layer.cornerRadius = 5
        takePhotoButton.addTarget(self, action: #selector(handleTakePhoto), for: .touchUpInside)
        return takePhotoButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        initialSetup()
    }
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.backgroundColor = .white
        
        view.addSubview(takePhotoButton)
        takePhotoButton.anchor(width: 120,
                               height: 45)
        takePhotoButton.centerX(inView: view)
        takePhotoButton.centerY(inView: view)
    }
    
    func setupNavigationController() {
        self.navigationItem.title = "Saved Translations"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func handleTakePhoto() {
        let cameraViewController = CameraViewController()
        cameraViewController.modalPresentationStyle = .fullScreen
        self.present(cameraViewController, animated: true, completion: nil)
    }
}
