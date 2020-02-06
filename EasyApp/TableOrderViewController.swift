//
//  TableOrderViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 5/8/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class TableOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
  
      var tables: [TableItem] = []
    

     let ref = Database.database().reference(withPath: "Order-items")
    
     var status: [OrderlistItem] = []
     var count : Int = 0
    var keyfoodid: String!
     var key: String!
    
    @IBOutlet weak var OrderTable: UITableView!

    var tablenum : String = ""

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return status.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableOrderTableViewCell
        let statusItem = status[indexPath.row]

        cell.foodnamelbl.text = statusItem.foodname
        cell.foodquantitylbl.text = String(statusItem.quantity)
        
        
        if count == 0 {
            
            if status[indexPath.row].status == 0{
                cell.foodstatuslbl.text = "รายการใหม่"
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
        } else {
            if status[indexPath.row].status == 0{
                cell.foodstatuslbl.text = "รายการใหม่"
                cell.foodstatuslbl.textColor = UIColor.red
            } else if status[indexPath.row].status == 1 {
                cell.foodstatuslbl.text = "กำลังทำอาหาร"
                cell.foodstatuslbl.textColor = UIColor.blue
            }
            else if status[indexPath.row].status == 2  {
                cell.foodstatuslbl.text = "เครื่องดื่มพร้อมเสิร์ฟ"
                cell.foodstatuslbl.textColor = UIColor.yellow
            }
            else if statusItem.status as! Int == 3 {
                cell.foodstatuslbl.text = "ได้รับเครื่องดื่มแล้ว"
                cell.foodstatuslbl.textColor = UIColor.green
            }
        }

        return cell
    }
    
    @IBOutlet weak var OpenMenu: UIBarButtonItem!
     var newStatus: [OrderlistItem] = []
    var type : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OpenMenu.target = self.revealViewController()
        OpenMenu.action = Selector("revealToggle:")
        
        
        if count == 0 {
            type = "อาหาร"
            print("ประเภท ",type)
        }
        else {
            type = "เครื่องดื่ม"
            print("ประเภท ",type)
        }
        
        

       // let userid : String = (Auth.auth().currentUser?.uid)!
       
//
//        ref.queryOrdered(byChild: "tableid").queryEqual(toValue: tablenum).observe(.childAdded, with: { snapshot in
//
//            for child in snapshot.children {
//                if let snapshot = child as? DataSnapshot,
//                    let statusItem = OrderlistItem(snapshot: snapshot) {
//
//                    newStatus.append(statusItem)
//
//                }
//            }
//             self.status = newStatus
//            self.OrderTable.reloadData()
//        })
//
//        OrderTable.delegate = self
//        OrderTable.dataSource = self
        
        
       ref.queryOrdered(byChild: "tableid").queryEqual(toValue: tablenum).observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
                
                for child in snapshot.children{
                    let DataSnap = child as! DataSnapshot
                    let getid = DataSnap.key //หมายเลขออเดอร์

                    self.ref.child(getid).child(self.type).observe(.childAdded, with: { snapshot in

                        if let child = snapshot as? DataSnapshot,
                            let statusItem = OrderlistItem(snapshot: child) {
                            
                            self.newStatus.append(statusItem)
                            
                            self.status = self.newStatus
                        }
                        
                        self.OrderTable.reloadData()
                    })
        
    }
    
        }
        })
        OrderTable.delegate = self
        OrderTable.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableOrderTableViewCell
        
        var statusItem = status[indexPath.row]
        
        if statusItem.status == 0{
            statusItem.status = 1
        } else if statusItem.status == 1{
            statusItem.status = 2
        }
        
        print("สถานะ ",status[indexPath.row].status)
        
        if status[indexPath.row].status == 0{
           status[indexPath.row].status = 1
            OrderTable.reloadRows(at: [indexPath], with: .automatic)
        }
            
        else if status[indexPath.row].status == 1 {
            status[indexPath.row].status = 2
            OrderTable.reloadRows(at: [indexPath], with: .automatic)
        }
        self.OrderTable.reloadRows(at: [indexPath], with: .automatic)
        
        let orderlistItem = ["foodid": statusItem.foodid as! String,
                                          "foodname": statusItem.foodname as! String,
                                          "quantity": statusItem.quantity as! Int,
                                          "amount": (statusItem.amount  as! Int?)!,
                                          "status": statusItem.status] as [String : Any]


        var key = self.status[indexPath.row].key
        var keyfoodid : String
        
        print("Table ",tablenum)
        
        ref.queryOrdered(byChild: "tableid").queryEqual(toValue: tablenum).observeSingleEvent(of: .value, with: { (snapshot) in
        
                    for child in snapshot.children {
                            let keyfoodid = (child as AnyObject).key as String
                        
                        self.ref.child(keyfoodid).child(self.type).child(self.status[indexPath.row].key).observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        for child in snapshot.children {
                        
                        let orderlistItemRef = self.ref.child(keyfoodid).child(self.type).child(self.status[indexPath.row].key)
                          //  orderlistItemRef.setValue(orderlistItem)
                            
                             self.ref.child(keyfoodid).child(self.type).child(self.status[indexPath.row].key).updateChildValues(["status": statusItem.status])
                            
                            print("Updateee")

                            
                            break
                           // self.viewDidLoad()
                        } 
                        
                        
                        }) 
                        
                }
                        
            })
        
    }
    
    
//    @IBAction func SegmentChange(_ sender: UISegmentedControl) {
//
//    }
//

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
    
}


