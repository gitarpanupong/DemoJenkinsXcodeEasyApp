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

struct MemberItem {
    let ref: DatabaseReference?
    let key: String
    let displayName: String
    let email: String
    
    init(displayName: String, email: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.displayName = displayName
        self.email = email
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let displayName = value["displayName"] as? String,
            let email = value["email"] as? String,
            let key = value["key"] as? String
            else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.displayName = displayName
        self.email = email
    }
    
    func toAnyObject() -> Any {
        return [
            "displayName": displayName,
            "email": email,
            "key" : key
        ]
    }
    
}

