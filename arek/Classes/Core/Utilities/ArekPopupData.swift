//
//  ArekPopupData.swift
//  Arek
//
//  Created by Ennio Masi on 28/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation

public struct ArekPopupData {
    var title: String!
    var message: String!
    var image: String!

    public init(title: String = "", message: String = "", image: String = "") {
        self.title = title
        self.message = message
        self.image = image
    }
}
