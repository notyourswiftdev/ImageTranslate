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

class CameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        requestPermissionAndShowCamera()
    }
    
    private func requestPermissionAndShowCamera() {
        
    }
}

