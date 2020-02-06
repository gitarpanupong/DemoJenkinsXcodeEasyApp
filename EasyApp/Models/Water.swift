//
//  Water.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 26/7/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import Foundation
import UIKit
class Water{
    var imageName: String?
    var waterName: String?
    var waterPrice: Int?
    var image: UIImage?
    
    convenience init(imageName: String, waterName: String, waterPrice: Int) {
        self.init()
        self.imageName = imageName
        self.waterName = waterName
        self.waterPrice = waterPrice
    }
}
