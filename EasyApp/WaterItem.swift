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

struct WaterItem {
    let ref: DatabaseReference?
    let key: String
    let waterid: String
    let name: String
    let price: String
    let idcategory: String
    let category: String
    let status: String
    let waterimage: String
    let waterimagepath: String

    
    
    init(waterid: String,name: String, price: String,idcategory: String,category: String,status: String,waterimage: String ,waterimagepath: String,key: String = "") {
        self.ref = nil
        self.key = key
        self.waterid = waterid
        self.name = name
        self.price = price
        self.idcategory = idcategory
        self.category = category
        self.status = status
        self.waterimage = waterimage
        self.waterimagepath = waterimagepath
        
    }
    
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let waterid = value["waterid"] as? String,
            let name = value["name"] as? String,
            let price = value["price"] as? String,
            let idcategory = value["idcategory"] as? String,
            let category = value["category"] as? String,
              let status = value["status"] as? String,
            let waterimage = value["waterimage"] as? String,
            let waterimagepath = value["waterimagepath"] as? String
            
            else {
                
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.waterid = waterid
        self.name = name
        self.price = price
        self.idcategory = idcategory
        self.category = category
        self.status = status
        self.waterimage = waterimage
        self.waterimagepath = waterimagepath
        
    }
    
    func toAnyObject() -> Any {
        return [
            "waterid": waterid,
            "name": name,
            "price": price,
            "idcategory" : idcategory,
            "category": category,
             "status": status,
            "waterimage": waterimage,
            "waterimagepath": waterimagepath
        ]
    }
    
}

