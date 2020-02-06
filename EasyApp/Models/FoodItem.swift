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

struct FoodItem {
    let ref: DatabaseReference?
    let key: String
    let foodid: String
    let name: String
    let price: String
     let idcategory: String
    let category: String
    let status: String
    let foodimage: String
     let foodimagepath: String


    
    
    
    
    init(foodid: String,name: String, price: String,idcategory: String,category: String,status: String,foodimage: String ,foodimagepath: String,key: String = "") {
        self.ref = nil
        self.key = key
        self.foodid = foodid
        self.name = name
        self.price = price
         self.idcategory = idcategory
        self.category = category
        self.status = status
        self.foodimage = foodimage
        self.foodimagepath = foodimagepath
      
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let foodid = value["foodid"] as? String,
            let name = value["name"] as? String,
            let price = value["price"] as? String,
             let idcategory = value["idcategory"] as? String,
            let category = value["category"] as? String,
            let status = value["status"] as? String,
            let foodimage = value["foodimage"] as? String,
              let foodimagepath = value["foodimagepath"] as? String
        
            else {
                
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
         self.foodid = foodid
        self.name = name
        self.price = price
        self.idcategory = idcategory
         self.category = category
         self.status = status
        self.foodimage = foodimage
        self.foodimagepath = foodimagepath
        
    }
    
    func toAnyObject() -> Any {
        return [
            "foodid": foodid,
            "name": name,
            "price": price,
             "idcategory" : idcategory,
             "category": category,
              "status": status,
            "foodimage": foodimage,
            "foodimagepath": foodimagepath
            
        ]
    }
    
}

