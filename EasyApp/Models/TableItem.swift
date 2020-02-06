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

struct TableItem {
    let ref: DatabaseReference?
    let key: String
    let name: String
    let status: String
     let statusfood: String
     let statuswater: String
    let time: String
    
    
    init(name: String, key: String, status: String,statusfood: String,statuswater: String ,time: String) {
        self.ref = nil
        self.key = key
        self.name = name
        self.status = status
          self.statusfood = statusfood
          self.statuswater = statuswater
        self.time = time
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let key = value["key"] as? String,
            let status = value["status"] as? String,
             let statusfood = value["statusfood"] as? String,
             let statuswater = value["statuswater"] as? String,
            let time = value["time"] as? String else {
                
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.status = status
        self.statusfood = statusfood
        self.statuswater = statuswater
        self.time = time
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "key": key,
            "status": status,
            "statusfood": statusfood,
            "statuswater": statuswater,
            "time": time
        ]
    }
    
}

