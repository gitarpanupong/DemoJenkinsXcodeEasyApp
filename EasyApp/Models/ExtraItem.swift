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

struct ExtraItem {
    let ref: DatabaseReference?
    let key: String
    let name: String
    let price: String
    let status: String
 
 
    
    
    init(key: String = "", name: String, price: String, status: String) {
        self.ref = nil
        self.key = key
        self.name = name
        self.price = price
        self.status = status
       
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let price = value["price"] as? String,
             let status = value["status"] as? String
             else {
                
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.price = price
        self.status = status
        
      
   
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "price": price,
            "status": status
           
        ]
    }
    
}

