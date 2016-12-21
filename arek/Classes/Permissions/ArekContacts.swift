//
//  ArekContacts.swift
//  Arek
//
//  Created by Ennio Masi on 31/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import Contacts

class ArekContacts: ArekBasePermission, ArekPermissionProtocol {
    var identifier: String = "ArekContacts"

    public init() {
        super.init(initialPopupData: ArekPopupData(title: "Contacts Service", message: "enable"),
                   reEnablePopupData: ArekPopupData(title: "Contacts Service", message: "re enable 🙏"))
    }
    
    func status(completion: @escaping ArekPermissionResponse) {
        switch Contacts.CNContactStore.authorizationStatus(for: CNEntityType.contacts) {
        case .authorized:
            return completion(.Authorized)
        case .denied, .restricted:
            return completion(.Denied)
        case .notDetermined:
            return completion(.NotDetermined)
        }
    }
    
    func askForPermission(completion: @escaping ArekPermissionResponse) {
        Contacts.CNContactStore().requestAccess(for: CNEntityType.contacts, completionHandler:  { (granted, error) in
            if granted {
                print("Contacts permission authorized by user ✅")
                return completion(.Authorized)
            }
            
            if let _ = error {
                return completion(.NotDetermined)
            }
            
            print("Contacts authorized by user ⛔️")
            return completion(.Denied)
        })
    }
}
