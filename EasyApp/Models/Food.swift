//
//  Food.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 22/7/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import Foundation
import UIKit
class Food{
    var imageName: String?
    var foodName: String?
    var foodPrice: Int?
    var image: UIImage?
    
    convenience init(imageName: String, foodName: String, foodPrice: Int) {
        self.init()
        self.imageName = imageName
        self.foodName = foodName
        self.foodPrice = foodPrice
    }
}
