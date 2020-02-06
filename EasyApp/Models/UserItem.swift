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

struct UserItem {
    let ref: DatabaseReference?
    let key: String
    let name: String
     let email: String
    
    init(name: String, email: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.name = name
         self.email = email
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let email = value["email"] as? String
            else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
         self.email = email
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "email": email
        ]
    }
    
}

