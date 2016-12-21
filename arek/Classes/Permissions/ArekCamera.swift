//
//  ArekCamera.swift
//  Arek
//
//  Created by Ennio Masi on 29/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import AVFoundation

public class ArekCamera: ArekBasePermission, ArekPermissionProtocol {
    public var identifier: String = "ArekCamera"

    public init() {
        super.init(initialPopupData: ArekPopupData(title: "I'm 📷", message: "enable"),
                   reEnablePopupData: ArekPopupData(title: "I'm 📷", message: "re enable 🙏"))
    }
    
    public func status(completion: @escaping ArekPermissionResponse) {
        switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) {
        case .notDetermined:
            return completion(.NotDetermined)
        case .restricted, .denied:
            return completion(.Denied)
        case .authorized:
            return completion(.Authorized)
        }
    }
    
    public func askForPermission(completion: @escaping ArekPermissionResponse) {
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (authorized) in
            if authorized {
                print("📷 permission authorized by user ✅")
                return completion(.Authorized)
            } else {
                print("📷 permission denied by user ⛔️")
                return completion(.Denied)
            }
        }
    }
}
