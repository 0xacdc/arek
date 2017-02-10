//
//  ArekEvents.swift
//  Arek
//
//  Created by Edwin Vermeer on 20/12/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import EventKit

open class ArekEvents: ArekBasePermission, ArekPermissionProtocol {
    open var identifier: String = "ArekEvents"
    
    public init() {
        super.init(initialPopupData: ArekPopupData(title: "I'm 📆", message: "enable"),
                   reEnablePopupData: ArekPopupData(title: "I'm 📆", message: "re enable 🙏"))
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
            let status = EKEventStore.authorizationStatus(for: .event)
            switch status {
            case .authorized:
                return completion(.authorized)
            case .restricted, .denied:
                return completion(.denied)
            case .notDetermined:
                return completion(.notDetermined)
            }
    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
            EKEventStore().requestAccess(to: .event) { granted, error in
                if let _ = error {
                    print("[🚨 Arek 🚨] 📆 permission not determined 🤔, error \(error)")
                    return completion(.notDetermined)
                }
                
                if granted {
                    print("[🚨 Arek 🚨] 📆 permission authorized by user ✅")
                    return completion(.authorized)
                }
                print("[🚨 Arek 🚨] 📆 permission denied by user ⛔️")
                return completion(.denied)
            }
    }
}
