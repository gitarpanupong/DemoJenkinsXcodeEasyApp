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

struct BillItem {
    let ref: DatabaseReference?
    var key: String
   // let orderid: String
    let time: String
    let totalPrice: Int
    let userid: String
    
    init(totalPrice: Int,time: String,userid: String ,key: String = "") {
        self.ref = nil
        self.key = key
    //    self.orderid = orderid
        self.totalPrice = totalPrice
         self.time = time
        self.userid = userid
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
         //   let orderid = value["orderid"] as? String ,
            let totalPrice = value["totalPrice"] as? Int,
             let time = value["time"] as? String,
             let userid = value["userid"] as? String else {
                
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
     //    self.orderid = orderid
         self.totalPrice = totalPrice
          self.time = time
         self.userid = userid
    }
    
    func toAnyObject() -> Any {
        return [
       //     "orderid": orderid,
            "totalPrice": totalPrice,
             "time": time,
             "userid": userid
        ]
    }
    
}

