//
//  TableItem.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 6/8/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct RestaurantItem {
    let ref: DatabaseReference?
    let key: String
    let resid: String
    let name: String
    let place: String
    let time: String
    let phone: String
    let resimage: String
    let resimagepath: String
    
    
    
    
    
    init(resid: String,name: String, place: String, time: String, phone: String, resimage: String,resimagepath: String ,key: String = "") {
        self.ref = nil
        self.key = key
        self.resid = resid
        self.name = name
        self.place = place
        self.time = time
         self.phone = phone
        self.resimage = resimage
          self.resimagepath = resimagepath
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let resid = value["resid"] as? String,
            let name = value["name"] as? String,
            let place = value["place"] as? String,
            let phone = value["phone"] as? String,
            let time = value["time"] as? String,
            let resimage = value["resimage"] as? String,
            let resimagepath = value["resimagepath"] as? String
            
            else {
                
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
         self.resid = resid
        self.name = name
        self.place = place
        self.phone = phone
        self.time = time
        self.resimage = resimage
         self.resimagepath = resimagepath
        
        
        
    }
    
    func toAnyObject() -> Any {
        return [
            "resid": resid,
            "name": name,
            "place": place,
             "phone": phone,
              "time": time,
            "resimage": resimage,
             "resimagepath": resimagepath,
            
            
        ]
    }
    
}

