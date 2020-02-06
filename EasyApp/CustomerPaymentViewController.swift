//
//  CustomerPaymentViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 6/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CustomerPaymentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    let userid : String = (Auth.auth().currentUser?.uid)!
    var newStatus: [OrderlistItem] = []
     var payment: [OrderlistItem] = []
    let ref = Database.database().reference(withPath: "Order-items")
    var sumlist : Int = 0
    var total : Int = 0
    var count : Int = 0
    var pay = [Int]()
    var quantity = [Int]()
    var sum: Int = 0
        var type : String = ""
    
    @IBOutlet weak var totalPricelbl: UILabel!
    
    @IBOutlet weak var paymentbtn: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return payment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerPaymentCell")  as! CustomerPaymentTableViewCell
        
        var paymentItem = payment[indexPath.row]
        
        cell.foodnamelbl.text = paymentItem.foodname
        cell.foodquantitylbl.text = String(paymentItem.quantity)
        cell.foodpricelbl.text = String(paymentItem.amount)
        
        sumlist =   paymentItem.amount*paymentItem.quantity
        cell.foodsumlbl.text = String(sumlist)
        
       // total += sumlist
        
        total += payment[indexPath.row].amount * payment[indexPath.row].quantity
        totalPricelbl.text = String(sum)
        
        return cell
        
    }
    


    @IBOutlet weak var tableView: UITableView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
           sum=0
        newStatus.removeAll()
        if count == 0 {
            type = "ทั้งหมด"
            
            
            ref.queryOrdered(byChild: "userid").queryEqual(toValue: userid).observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.exists() {
                    
                    for child in snapshot.children{
                        let DataSnap = child as! DataSnapshot
                        let getid = DataSnap.key //หมายเลขออเดอร์
                        
                        //  print("getid ",getid)
                        
                        self.ref.child(getid).child("อาหาร").observe(.childAdded, with: { snapshot in
                            
                            if let child = snapshot as? DataSnapshot,
                                let statusItem = OrderlistItem(snapshot: child) {
                                
                                self.newStatus.append(statusItem)
                                
                                self.payment = self.newStatus
                                
                                self.sum += statusItem.amount * statusItem.quantity
                                
                            }
                             self.tableView.reloadData()
                            
                        })
                        self.ref.child(getid).child("เครื่องดื่ม").observe(.childAdded, with: { snapshot in
                            
                            if let child = snapshot as? DataSnapshot,
                                let statusItem = OrderlistItem(snapshot: child) {
                                
                                self.newStatus.append(statusItem)
                                
                                self.payment = self.newStatus
                               
                                self.sum += statusItem.amount * statusItem.quantity
                                
                            }
                            
                            self.tableView.reloadData()
                            
                            
                        })
                        
                    }
                }
            })
    
            
            tableView.delegate = self
            tableView.dataSource = self
            
            
            
            
            
            
        }
        else if count == 1{
            type = "อาหาร"
            
            
            ref.queryOrdered(byChild: "userid").queryEqual(toValue: userid).observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.exists() {
                    
                    for child in snapshot.children{
                        let DataSnap = child as! DataSnapshot
                        let getid = DataSnap.key //หมายเลขออเดอร์
                        
                        //  print("getid ",getid)
                        
                        self.ref.child(getid).child(self.type).observe(.childAdded, with: { snapshot in
                            
                            if let child = snapshot as? DataSnapshot,
                                let statusItem = OrderlistItem(snapshot: child) {
                                
                                self.newStatus.append(statusItem)
                                
                                self.payment = self.newStatus
                                print("pay ",(statusItem.amount * statusItem.quantity))
                                
                                self.sum += statusItem.amount * statusItem.quantity
                                print("sum ", self.sum )
                                
                            }
                            
                            self.tableView.reloadData()
                            
                            
                        })
                        
                    }
                }
            })
            
            tableView.delegate = self
            tableView.dataSource = self
            
            
            

        }
        else if count == 2{
            type = "เครื่องดื่ม"
        

            ref.queryOrdered(byChild: "userid").queryEqual(toValue: userid).observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.exists() {
                    
                    for child in snapshot.children{
                        let DataSnap = child as! DataSnapshot
                        let getid = DataSnap.key //หมายเลขออเดอร์
                        
                        //  print("getid ",getid)
                        
                        self.ref.child(getid).child(self.type).observe(.childAdded, with: { snapshot in
                            
                            if let child = snapshot as? DataSnapshot,
                                let statusItem = OrderlistItem(snapshot: child) {
                                
                                self.newStatus.append(statusItem)
                                
                                self.payment = self.newStatus
                                print("pay ",(statusItem.amount * statusItem.quantity))
                                    
                                self.sum += statusItem.amount * statusItem.quantity
                                print("sum ", self.sum )
                                
                            }
                            
                            self.tableView.reloadData()
                            
                            
                        })
                        
                    }
                }
            })
        
            tableView.delegate = self
            tableView.dataSource = self
        
         }
 
    }
    
    @IBAction func setmentchange(_ sender: UISegmentedControl) {
        print("index : ",sender.selectedSegmentIndex)
        
        
        if sender.selectedSegmentIndex == 0 {
            count = 0
               sum=0
            newStatus.removeAll()
            self.viewDidLoad()
            print(count)
        }
        else if sender.selectedSegmentIndex == 1 {
            count = 1
               sum=0
            newStatus.removeAll()
            self.viewDidLoad()
            print(count)
        }
        else if sender.selectedSegmentIndex == 2 {
            count = 2
              newStatus.removeAll()
            sum=0
            self.viewDidLoad()
            print(count)
        }
    }
    
    
    
     let tableref = Database.database().reference(withPath: "Table-items")
    
    @IBAction func callbtn(_ sender: Any) {
        print("กดดดดดด ")
        ref.queryOrdered(byChild: "userid").queryEqual(toValue: userid).observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children{
                
                let DataSnap = child as! DataSnapshot
                let getid = DataSnap.key
                print("โต๊ะ1 ",getid)
                self.ref.child(getid).queryOrdered(byChild: "tableid").observeSingleEvent(of: .value, with: { (snapshot) in
                   let userDict = snapshot.value as! [String: Any]
                    let table = userDict["tableid"] as! String
                        print("โต๊ะ ",table)
                    
                    ///////////////////////////
                    
                    self.tableref.queryOrdered(byChild: "name").queryEqual(toValue: table).observeSingleEvent(of: .value, with: { (snapshot) in
                        for child in snapshot.children{
                            
                            let DataSnap = child as! DataSnapshot
                            let getid = DataSnap.key
                            
                            print("table id ",getid)
                            self.tableref.child(getid).updateChildValues(["status": "call"])
                        }
                        
                    })
                    
                    
                    
                    //////////////////////////
                    
                })
                
                
          
            }
            
        })
        
        
    }
    
    
    
  
    
    
    
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        print("Did Appear ")
//        self.viewDidLoad()
//        self.tableView.reloadData()
//    }

}
