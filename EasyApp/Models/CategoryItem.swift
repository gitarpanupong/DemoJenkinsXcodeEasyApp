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

struct CategoryItem {
    let ref: DatabaseReference?
    let key: String
    let name: String
    let type: String
    let status: String
    let id: String
    
    init(name: String,type: String,status: String,id: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.name = name
        self.type = type
        self.status = status
         self.id = id
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let type = value["type"] as? String,
             let status = value["status"] as? String,
            let id = value["id"] as? String else {
                
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
         self.type = type
         self.status = status
         self.id = id
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
             "type": type,
             "status": status,
             "id" : id
        ]
    }
    
}

