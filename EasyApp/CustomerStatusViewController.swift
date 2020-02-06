//
//  CustomerStatusViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 3/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CustomerStatusViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var status: [OrderlistItem] = []
    var keyfoodid: String!
       var count : Int = 0
    var key: String!
    
    @IBOutlet weak var tableView: UITableView!
    let ref = Database.database().reference(withPath: "Order-items")
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return status.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
  
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCell")  as! CustomerStatusTableViewCell
        
        var statusItem = status[indexPath.row]
            
        cell.foodnamelbl.text = statusItem.foodname
         cell.foodquantitylbl.text = String(statusItem.quantity)

       
        if statusItem.status as! Int == 0{
            cell.foodstatuslbl.text = "รอรับเมนู..."
            cell.foodstatuslbl.textColor = UIColor.red
        }
        else if status[indexPath.row].status == 1 {
            cell.foodstatuslbl.text = "กำลังทำอาหาร"
            cell.foodstatuslbl.textColor = UIColor.blue
        }
            
        else if status[indexPath.row].status == 2  {
            cell.foodstatuslbl.text = "อาหารพร้อมเสิร์ฟ"
            cell.foodstatuslbl.textColor = UIColor.yellow
        }
        
        else if statusItem.status as! Int == 3 {
            cell.foodstatuslbl.text = "ได้รับอาหารแล้ว"
            cell.foodstatuslbl.textColor = UIColor.green
        }
        
        self.tableView.rowHeight = 100

        return cell
    }
    
     var type : String!
         var newStatus: [OrderlistItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.tableView.reloadData()
        if count == 0 {
            type = "อาหาร"
            print("ประเภท ",type)
        }
        else {
            type = "เครื่องดื่ม"
            print("ประเภท ",type)
        }
        
        let userid : String = (Auth.auth().currentUser?.uid)!
   
//       ref.child(type).queryOrdered(byChild: userid).observe(.childAdded, with: { snapshot in
//
//            for child in snapshot.children {
//
//
//                    if let snapshot = child as? DataSnapshot,
//                        let statusItem = OrderlistItem(snapshot: snapshot) {
//
//                        newStatus.append(statusItem)
//
//                        self.status = newStatus
//                }
//            }
//
//            self.tableView.reloadData()
//                })

        ref.queryOrdered(byChild: "userid").queryEqual(toValue: userid).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
               
                
                for child in snapshot.children{
                    let DataSnap = child as! DataSnapshot
                    let getid = DataSnap.key //หมายเลขออเดอร์
                     print("keyid ",getid)

                    self.ref.child(getid).child(self.type).observe(.childAdded, with: { snapshot in
                   
                        if snapshot.hasChildren(){
                            print("มี")
                        } else {
                            print("ไม่มี")
                        }
                      
                        if let child = snapshot as? DataSnapshot,
                            let statusItem = OrderlistItem(snapshot: child) {
                        
                            
                            self.newStatus.append(statusItem)
                        
                            self.status = self.newStatus
                            }
                        
                    
                            self.tableView.reloadData()
                        
                        
                    })
                    
                   
//                    self.ref.child(getid).child(self.type).queryOrdered(byChild: userid).observe(.childAdded, with: { snapshot in
//                        for child in snapshot.children{
//                            let DataSnap2 = child as! DataSnapshot
//                            let getid2 = DataSnap.key
//
//                            if let snapshot = child as? DataSnapshot,
//                                let statusItem = OrderlistItem(snapshot: snapshot) {
//                                newStatus.append(statusItem)
//
//                                    self.status = newStatus
//                                }
//                        }
//
//
//                    })
                }
            }
            
                
            })

        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userid : String = (Auth.auth().currentUser?.uid)!
              let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCell")  as! CustomerStatusTableViewCell
                
                var statusItem = status[indexPath.row]
                
                if statusItem.status == 2{
                    statusItem.status = 3
                }
        
                print("สถานะ ",status[indexPath.row].status)
                
                if status[indexPath.row].status == 2{
                    status[indexPath.row].status = 3
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
        
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                
                let orderlistItem = ["foodid": statusItem.foodid as! String,
                                     "foodname": statusItem.foodname as! String,
                                     "quantity": statusItem.quantity as! Int,
                                     "amount": (statusItem.amount  as! Int?)!,
                                     "status": statusItem.status] as [String : Any]
                
                
                var key = self.status[indexPath.row].key
                var keyfoodid : String
        
                
                ref.queryOrdered(byChild: "userid").queryEqual(toValue: userid).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    for child in snapshot.children {
                        let keyfoodid = (child as AnyObject).key as String
                        
                        
                      //  print("status ",self.status[indexPath.row].key)
                        self.ref.child(keyfoodid).child(self.type).child(self.status[indexPath.row].key).observeSingleEvent(of: .value, with: { (snapshot) in
                            
                            for child in snapshot.children {
                                
                                let orderlistItemRef = self.ref.child(keyfoodid).child(self.type).child(self.status[indexPath.row].key)
                              
                               // orderlistItemRef.setValue(orderlistItem)
                                  self.ref.child(keyfoodid).child(self.type).child(self.status[indexPath.row].key).updateChildValues(["status": statusItem.status])
                                
                                print("eiei")
                                
                                
                                break
                                // self.viewDidLoad()
                            }
                            
                            
                        })
                        
                    }
                    
                })
                
        }
        
    
    @IBAction func SegmentChange(_ sender: UISegmentedControl) {

        print("index : ",sender.selectedSegmentIndex)


        if sender.selectedSegmentIndex == 0 {
            count = 0
             newStatus.removeAll()
            self.viewDidLoad()
            print(count)
        }
        if sender.selectedSegmentIndex == 1 {
            count = 1
             newStatus.removeAll()
            self.viewDidLoad()
            print(count)
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            if status[indexPath.row].status == 0 {
                let statusItem = status[indexPath.row]
                print("ชื่ออาหาร ",statusItem.foodname)
                self.tableView.reloadData()
                statusItem.ref?.removeValue()
            }
        }
    }


//    @IBAction func stepperAction(_ sender: UIStepper) {
//
//        let button = sender.tag
//        // let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell") as! OrderTableViewCell
//
//        let indexPath = NSIndexPath(row:button, section:0)
//        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! OrderTableViewCell
//        let value = Int(sender.value)
//        var value2 = Int(sender.value)
//
//        //sum1[button] = Int(orderfood[indexPath.row]["ราคา"]! as! String)!
//        sum1[button] = Int(orderfood[indexPath.row]["ราคา"]! as! String)! * value
//        print("sum1 ",sum1[indexPath.row])
//
//        allsum = 0
//        for item in sum1  {
//            //stringsum = sum1[item]
//            print("item",item)
//            allsum += item
//
//        }
//
//        print("allsum = ",allsum)
//
//        sumlbl.text = String(allsum)
//
//        var search = cell.foodNamelbl.text
//        for var amount in orderfood
//        {
//            if amount["ชื่อ"] as! String == search{
//                //   amount["จำนวน"] = value2 as Int? as AnyObject?
//                orderfood[indexPath.row]["จำนวน"] = value2 as AnyObject
//                print(orderfood)
//            }
//            count += 1
//        }
//        cell.amountlbl.text = String(value)
//
//
//    }
    



//    var counter = 15
//
//    @objc func updateCounter() {
//        //example functionality
// let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCell")  as! CustomerStatusTableViewCell
//
//        if counter > 0 {
//             cell.foodtablelbl.text = String(counter)
//            print("\(counter) seconds to the end of the world")
//            newStatus.removeAll()
//            counter -= 1
//        } else {
//            print("Boom")
//             newStatus.removeAll()
//            self.viewDidLoad()
//
//        }
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//         Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
//    }
//
}
