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

struct OrderItem {
    let ref: DatabaseReference?
    let key: String
    let orderid: String
    let tableid: String
      let totalPrice: Int
    let pay: String
    let userid: String
    
    init(orderid: String,tableid: String,totalPrice: Int,pay: String,userid: String ,key: String = "") {
        self.ref = nil
        self.key = key
        self.orderid = orderid
        self.tableid = tableid
        self.totalPrice = totalPrice
        self.pay = pay
        self.userid = userid
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let orderid = value["orderid"] as? String ,
            let tableid = value["tableid"] as? String ,
            let totalPrice = value["totalPrice"] as? Int,
               let pay = value["pay"] as? String,
             let userid = value["userid"] as? String else {
                
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
         self.orderid = orderid
        self.tableid = tableid
         self.totalPrice = totalPrice
          self.pay = pay
         self.userid = userid
    }
    
    func toAnyObject() -> Any {
        return [
            "orderid": orderid,
            "tableid": tableid,
            "totalPrice": totalPrice,
            "pay": pay,
             "userid": userid
            
        ]
    }
    
}

