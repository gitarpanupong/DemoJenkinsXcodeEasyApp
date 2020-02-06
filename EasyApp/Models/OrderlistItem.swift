//
//  OrderlistItem.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 3/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct OrderlistItem {
    let ref: DatabaseReference?
    let key: String
    let orderitemid: String
    let foodname: String
    let foodid: String
    let type: String
    let orderid: String
    let quantity: Int
    let amount: Int
    var status: Int
    
    
    
    init(orderitemid: String ,foodid: String,foodname: String,type: String,orderid: String,quantity: Int,amount: Int,status: Int, key: String = "") {
        self.ref = nil
        self.key = key
        self.orderitemid = orderitemid
        self.foodname = foodname
        self.foodid = foodid
        self.type = type
        self.orderid = orderid
        self.quantity = quantity
        self.amount = amount
         self.status = status
   
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
             let orderitemid = value["orderitemid"] as? String,
            let foodid = value["foodid"] as? String,
            let foodname = value["foodname"] as? String,
              let type = value["type"] as? String,
              let orderid = value["orderid"] as? String,
            let quantity = value["quantity"] as? Int,
            let amount = value["amount"] as? Int,
            let status = value["status"] as? Int else {
                
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.orderitemid = orderitemid
        self.foodname = foodname
        self.foodid = foodid
        self.type = type
        self.orderid = orderid
        self.quantity = quantity
        self.amount = amount
         self.status = status

        
    }
    
    func toAnyObject() -> Any {
        return [
            "orderitemid": orderitemid,
             "foodname": foodname,
            "foodid": foodid,
            "type": type,
            "orderid": orderid,
            "quantity": quantity,
            "amount": amount,
             "status": status
        ]
    }
    
}

