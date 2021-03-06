//
//  Arek.swift
//  Arek
//
//  Copyright (c) 2016 Ennio Masi
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import UIKit

public typealias ArekPermissionResponse = (ArekPermissionStatus) -> Void

public protocol ArekPermissionProtocol: class {
    var identifier: String { get }
    /**
     This is the key method to know if a permission has been authorized or denied.

     Parameter completion: this closure is invoked with the current permission status (ArekPermissionStatus)
     */
    func status(completion: @escaping ArekPermissionResponse)

    /**
     This is the key method to manage the request for a permission.

     The behaviour is based on the ArekConfiguration set in the permission during the initialization phase.


     Parameter completion: this closure is invoked with the current permission status (ArekPermissionStatus)
     */
    func manage(completion: @escaping ArekPermissionResponse)
    func askForPermission(completion: @escaping ArekPermissionResponse)
}

/**
 ArekBasePermission is a root class and each permission inherit from it.

 Don't instantiate ArekBasePermission directly.
 */

/**
 ArekBasePermission is a root class and each permission inherit from it.
 
 Don't instantiate ArekBasePermission directly.
 */
open class ArekBasePermission {
    public init() {}

    open func manage(completion: @escaping ArekPermissionResponse) {
        (self as? ArekPermissionProtocol)?.status { status in
            self.managePermission(status: status, completion: completion)
        }
    }

    private func manageInitialPopup(completion: @escaping ArekPermissionResponse) {
        (self as? ArekPermissionProtocol)?.askForPermission(completion: completion)
    }

    internal func managePermission(status: ArekPermissionStatus, completion: @escaping ArekPermissionResponse) {
        switch status {
        case .notDetermined:
            self.manageInitialPopup(completion: completion)
            break
        case .denied:
            return completion(.denied)
        case .authorized:
            return completion(.authorized)
        case .notAvailable:
            break
        }
    }
}
