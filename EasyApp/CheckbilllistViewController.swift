//
//  CheckbilllistViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 6/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CheckbilllistViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var payment: [OrderlistItem] = []
    var checklist: [OrderlistItem] = []
     var order: [OrderItem] = []
     var bill: [BillItem] = []
    var newStatus: [OrderlistItem] = []
      var orderlists: [OrderlistItem] = []
      var orderlistsfoods: [OrderlistItem] = []
      var orderlistswaters: [OrderlistItem] = []
    let ref = Database.database().reference(withPath: "Order-items")
     let orderlistref = Database.database().reference(withPath: "Orderlist-items")
     let billref = Database.database().reference(withPath: "Bill-items")
     let tableref = Database.database().reference(withPath: "Table-items")
    var sumlist : Int = 0
    var total : Int = 0
    var table : String = ""
    var type : String = ""
    var pay = [Int]()
    var quantity = [Int]()
    var sum: Int = 0
     var sum2: Int = 0
    var count : Int = 0
    var tables: [TableItem] = []
    
    
    
  //     let userid : String = (Auth.auth().currentUser?.uid)!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPricelbl: UILabel!

    @IBOutlet weak var btnpay: UIButton!
    
    var countbill: Int = 0
    
    func checkbill(){
       billref.observe(.value, with: { snapshot in
            print("bilcount ",snapshot.childrenCount)
        self.countbill = Int(snapshot.childrenCount)
        })
        
    }
    
    func readorder() {
        print("Why ",table)
        ref.queryOrdered(byChild: "tableid").queryEqual(toValue: table).observe(.value, with: { (snapshot: DataSnapshot) in
                        var newOrders: [OrderItem] = []
                        for child in snapshot.children{
                                print("child ",child)
                                if let snapshot = child as? DataSnapshot,
                                    let orderItem = OrderItem(snapshot: snapshot) {
                                    if orderItem.pay == "no" {
                                        newOrders.append(orderItem)
                                    }
                            }
            }
              self.order = newOrders
         self.orderlist()
            
        })

    }
     
             var newOrderslist: [OrderlistItem] = []
        var checkinput: Int = 0
    
             func orderlist(){
                    
                orderlists.removeAll()
                  print("count ",self.orderlists.count)
                
                for i in order{
          //          if i.pay == "no" {
                      print("OrderList ")
                    sum = 0
                    sum3 = 0
                      
                    self.orderlistref.queryOrdered(byChild: "orderid").queryEqual(toValue: i.orderid).observe(.value, with: { (snapshot: DataSnapshot)  in
         //               self.countorder = Int(snapshot.childrenCount)
         //                print("จำวนนนน ",self.countorder)
                 
                   
                  
                     
                                                     //  print("โต๊ะ ",table)
                          for child in snapshot.children {
                                  if let snapshot = child as? DataSnapshot,
                                      let orderlistItem = OrderlistItem(snapshot: snapshot) {
                                        
                                        if orderlistItem.status != 4 {
                                    print("eiei ",orderlistItem.orderitemid)
                                        self.newOrderslist.append(orderlistItem)
                                    
                                    if self.orderlists.count == 0 {
//                                            self.orderlists.append(orderlistItem)
//                                            self.sum += orderlistItem.amount * orderlistItem.quantity
//                                            self.sum3 += orderlistItem.amount * orderlistItem.quantity
                                            self.checkinput = 0
                                    }
                                    else{
                                        for (index ,i) in self.orderlists.enumerated() {
                                            if i.orderitemid == orderlistItem.orderitemid {
                                                self.checkinput = 1
                                                self.orderlists[index] = orderlistItem
                                                  print("orderlist ",orderlistItem.foodname)
                                                    break
                                            }
                                        }
                                    }
                                    
                                    if self.checkinput == 0 {
                                            self.orderlists.append(orderlistItem)
                                            self.sum += orderlistItem.amount * orderlistItem.quantity
                                            self.sum3 += orderlistItem.amount * orderlistItem.quantity
                                    }
                                    
                                    
                                                   
                                        }
                                  }
                          }
                          
                  //  self.orderlists = self.newOrderslist
                        print("haha")
            // self.tableView.reloadData()
                       self.tableView.reloadData()
                 })
                   
                }
               self.tableView.reloadData()
            //    }
               
             }
    
    
//    func realcheck(){
//        orderlists.removeAll()
//
//        for i in newOrderslist{
//      //      for j in orderlists {
//          //      if j.orderitemid != i.orderitemid{
//                        orderlists.append(i)
//             //   }
//           // }
//        }
//         self.tableView.reloadData()
//       //newOrderslist.removeAll()
//
//        print("Update",newOrderslist)
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        checkbill()
        readorder()
      // orderlist()
      
    //    Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)

//        ref.queryOrdered(byChild: table).observe(.childAdded, with: { snapshot in
//
//            for child in snapshot.children {
//
//                // print("child1 ",child)
//                if let snapshot = child as? DataSnapshot,
//                    let statusItem = OrderlistItem(snapshot: snapshot) {
//                    self.newStatus.append(statusItem)
//                    self.payment = self.newStatus
//                }
//            }
//
//
//           self.tableView.reloadData()
//        })
        
        allbtn.layer.cornerRadius = 10
        allbtn.layer.borderWidth = 2
        btnpay.layer.cornerRadius = 10
        btnpay.layer.borderWidth = 2
        
                   sum=0
        totalPricelbl.text = String(0)
            /*    newStatus.removeAll()
                if count == 0 {
                    type = "ทั้งหมด" */
                 //   print("อิหยังวะ")
            
        /*         //   ref.queryOrdered(byChild: "userid").queryEqual(toValue: userid).observeSingleEvent(of: .value, with: { (snapshot) in
        ref.queryOrdered(byChild: "tableid").queryEqual(toValue: table).observe(.value, with: { (snapshot: DataSnapshot) in
                        if snapshot.exists() {
                            
                            for child in snapshot.children{
                                let DataSnap = child as! DataSnapshot
                                let getid = DataSnap.key //หมายเลขออเดอร์
                                
                                //  print("getid ",getid)
                                
                                self.orderlistref.queryOrdered(byChild: "orderid").queryEqual(toValue: getid).observe(.childAdded, with: { snapshot in
                                      
                                      if let child = snapshot as? DataSnapshot,
                                          let orderlistItem = OrderlistItem(snapshot: snapshot) {
                                                        
                                                        self.orderlists.append(orderlistItem)
                                                        
                                        if orderlistItem.type == "อาหาร" {
                                            self.orderlistsfoods.append(orderlistItem)
                                        } else {
                                            self.orderlistswaters.append(orderlistItem)
                                        }
                                        
                                                        self.sum += orderlistItem.amount * orderlistItem.quantity
                                                    self.sum3 += orderlistItem.amount * orderlistItem.quantity
                                     
                                                // var newOrderslist: [OrderlistItem] = []
                                              }
                                 //   self.totalPricelbl.text = String(self.sum)
                                            
                                         //   self.realcheck()
                                           self.tableView.reloadData()
                                            
                                    })
                                  

                               }
                                          }
                      
                                         
                                })
        */
             //   tableView.delegate = self
           //       tableView.dataSource = self
                  
         // self.realcheck()
/*
        else if count == 1{
            type = "อาหาร"
            
            
            ref.queryOrdered(byChild: "tableid").queryEqual(toValue: table).observeSingleEvent(of: .value, with: { (snapshot) in
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
            
            
            ref.queryOrdered(byChild: "tableid").queryEqual(toValue: table).observeSingleEvent(of: .value, with: { (snapshot) in
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
        
            */
    }
    
    var counter = 10

    @objc func updateCounter() {
        //example functionality
        if counter > 0 {
            print("\(counter) seconds to the end of the world")
            counter -= 1
        }
    }
    
    
  
    
    @IBAction func setmentChange(_ sender: UISegmentedControl) {
           if sender.selectedSegmentIndex == 0 {
                 count = 0
                 type = "ทั้งหมด"
               //     sum=0
                  sum2=0
                 //orderlists.removeAll()
               //  self.viewDidLoad()
            
             for i in TickItem {
              
              self.sum2 += i.amount * i.quantity
                 
               
            }
              totalPricelbl.text = String(sum2)
        //  tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .fade)
                self.tableView.reloadData()
                // print(count)
             }
             else if sender.selectedSegmentIndex == 1 {
                 count = 0
                 type = "อาหาร"
                 sum2=0
     
                         for i in orderlists {
                             if i.type == type {
                                 count = count + 1
                                 self.sum4 += i.amount * i.quantity
                             }
                         }
            for i in TickItem {
                    if i.type == type {
                         self.sum2 += i.amount * i.quantity
                    }
                
            }
                
                  totalPricelbl.text = String(sum2)
                  //  sum=0
               //  orderlists.removeAll()
            checklist.removeAll()
            check.removeAll()
            // tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .fade)
                 self.tableView.reloadData()
               //  print(count)
             }
             else if sender.selectedSegmentIndex == 2 {
                 count = 0
                 type = "เครื่องดื่ม"
              //   orderlists.removeAll()
               //  sum=0
                 sum2=0
                 for i in orderlists {
                    if i.type == type {
                          count = count + 1
                         self.sum4 += i.amount * i.quantity
                    }
                  }
            
            
            for i in TickItem {
                if i.type == type {
                    self.sum2 += i.amount * i.quantity
                }
                        
                }
                  totalPricelbl.text = String(sum2)
                 //self.viewDidLoad()
            
            checklist.removeAll()
                      check.removeAll()
         //  tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .fade)
                 self.tableView.reloadData()
            
           
                // print(count)
             }

    }
    
    var num: Int = 0
    var check: [[String]] = []
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell = tableView.dequeueReusableCell(withIdentifier: "CheckbilllistCell")  as! CheckbilllistTableViewCell
            cell.layer.cornerRadius = 15
              cell.layer.borderWidth = 2
        
        
        cell.btnplus.tag = indexPath.row
        cell.btnminus.tag = indexPath.row
        
         cell.btnplus.addTarget(self, action: #selector(plusbtn(_:)), for: .touchUpInside)
        
          cell.btnminus.addTarget(self, action: #selector(minusbtn(_:)), for: .touchUpInside)
        
        
        
           // cell.contentView.backgroundColor = #colorLiteral(red: 0.9510123134, green: 0.3623146415, blue: 0.3538915515, alpha: 1)
        
        if TickItem.count == 0{
             cell.contentView.backgroundColor = #colorLiteral(red: 0.9510123134, green: 0.3623146415, blue: 0.3538915515, alpha: 1)
        }
        
      
        
    
        
            let paymentItem = orderlists[indexPath.row]
        
          
                 if type == "ทั้งหมด" || type == "" {

                    print("everythings is ok ",paymentItem.quantity)
                       cell.foodnamelbl.text = paymentItem.foodname
                       cell.foodquantitylbl.text = String(paymentItem.quantity)
                       cell.foodpricelbl.text = String(paymentItem.amount)
                       
                       sumlist =   paymentItem.amount*paymentItem.quantity
                       cell.foodamountlbl.text = String(sumlist)
                          cell.contentView.backgroundColor = #colorLiteral(red: 0.9510123134, green: 0.3623146415, blue: 0.3538915515, alpha: 1)
                    
                       for i in TickItem {
                                  
                        
                                 if i.orderitemid == orderlists[indexPath.row].orderitemid {
                                    print(i.foodname," Tick ",orderlists[indexPath.row].foodname)
                                      cell.contentView.backgroundColor = #colorLiteral(red: 0.7559726834, green: 0.8736498356, blue: 0.01575271413, alpha: 1)
                                 }
                        }
                      // total += sumlist
                     //  total += payment[indexPath.row].amount * payment[indexPath.row].quantity
                         
                     //  totalPricelbl.text = String(sum)
                   }
                   else {
                      //  var paymentItem2 = orderlists[indexPath.row]
                    
                  //  num += 1
             
               /*     if indexPath.row == 0 {
                        check.removeAll()
                       print("ประเภท ",type)
                        for i in orderlists {
                            if i.type == type {
                                print("name ",i.foodname)
                                     
                                check.append([String(num),i.orderitemid])
                                num += 1
                            }
                        }
                    }
                    else if String(indexPath.row) == check[indexPath.row][0] {
                        print(String(indexPath.row)," == ",check[indexPath.row][0])
                            
                         for i in orderlists {
                            
                            if i.orderitemid == check[indexPath.row][1] {
                                
                                cell.foodnamelbl.text = i.foodname
                                cell.foodquantitylbl.text = String(i.quantity)
                                cell.foodpricelbl.text = String(i.amount)
                                sumlist =   i.amount*i.quantity
                                cell.foodamountlbl.text = String(sumlist)
                                
                            }
                        }
                    }
                    */
                    
                    if type == "อาหาร" {
                        print("อาหาร ",orderlistsfoods[indexPath.row].foodname)
                        cell.foodnamelbl.text = orderlistsfoods[indexPath.row].foodname
                         cell.foodquantitylbl.text = String(orderlistsfoods[indexPath.row].quantity)
                         cell.foodpricelbl.text = String(orderlistsfoods[indexPath.row].amount)
                          sumlist =   orderlistsfoods[indexPath.row].amount * orderlistsfoods[indexPath.row].quantity
                          cell.foodamountlbl.text = String(sumlist)
                        cell.contentView.backgroundColor = #colorLiteral(red: 0.9510123134, green: 0.3623146415, blue: 0.3538915515, alpha: 1)
                                          
                        for i in TickItem {
                                    print("Tickfood ",i.foodname)
                                  if i.orderitemid == orderlistsfoods[indexPath.row].orderitemid {
                                       cell.contentView.backgroundColor = #colorLiteral(red: 0.7559726834, green: 0.8736498356, blue: 0.01575271413, alpha: 1)
                                  }
                                 
                              }
                    }else {
                        print("น้ำ ",orderlistswaters[indexPath.row].foodname)
                        cell.foodnamelbl.text = orderlistswaters[indexPath.row].foodname
                         cell.foodquantitylbl.text = String(orderlistswaters[indexPath.row].quantity)
                        cell.foodpricelbl.text = String(orderlistswaters[indexPath.row].amount)
                        sumlist =   orderlistswaters[indexPath.row].amount * orderlistswaters[indexPath.row].quantity
                       cell.foodamountlbl.text = String(sumlist)
                        cell.contentView.backgroundColor = #colorLiteral(red: 0.9510123134, green: 0.3623146415, blue: 0.3538915515, alpha: 1)
                                          
                        for i in TickItem {
                           print("Tickwater ",i.foodname)
                         if i.orderitemid == orderlistswaters[indexPath.row].orderitemid {
                            cell.contentView.backgroundColor = #colorLiteral(red: 0.7559726834, green: 0.8736498356, blue: 0.01575271413, alpha: 1)
                            }
                            
                        }
                    }
                    
                    /*
                    
                    // print("asda")
                    for i in orderlists {
                        if indexPath.row == 0 && i.type == type{
                       //  print("aaaaa")
                            check.append([String(num),i.orderitemid])
                            checklist.append(i)
                            num += 1
                        }
                    }
               //    print("checkkk ",checklist)

                    for i in TickItem {
                        if i.orderitemid == checklist[indexPath.row].orderitemid {
                            cell.contentView.backgroundColor = #colorLiteral(red: 0.7559726834, green: 0.8736498356, blue: 0.01575271413, alpha: 1)
                        }
                    }
                    
                    
                         
//                    if String(indexPath.row) == check[indexPath.row][0]{
//                      //  print(indexPath.row," check ",check[indexPath.row][1])
//                        print(indexPath.row," check ",checklist[indexPath.row].foodname)
//                          cell.foodnamelbl.text = checklist[indexPath.row].foodname
//                    }
                    
                     cell.foodnamelbl.text = checklist[indexPath.row].foodname
                 
                     cell.foodquantitylbl.text = String(checklist[indexPath.row].quantity)
                      cell.foodpricelbl.text = String(checklist[indexPath.row].amount)
                      sumlist =   checklist[indexPath.row].amount * checklist[indexPath.row].quantity
                     cell.foodamountlbl.text = String(sumlist)
                    
                    */
                    
                    /*
                       for i in orderlists {
                           if i.type == type {

                           // print(num," what ",i.foodname)
                            //   cell.foodnamelbl.text = i.foodname
                                cell.foodquantitylbl.text = String(i.quantity)
                                cell.foodpricelbl.text = String(i.amount)

                                sumlist =   i.amount*i.quantity
                                cell.foodamountlbl.text = String(sumlist)
                             num += 1
                             }

                    }*/
           //             self.sum2 += paymentItem.amount * paymentItem.quantity
           //            print(self.sum2," +=  ",paymentItem.amount," * ",paymentItem.quantity)
           //             totalPricelbl.text = String(sum2)
               //    }
        }
                   
                   return cell

       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         if type == "ทั้งหมด" || type == "" {
//                     return orderlists.count
//                }
//                else{
//                     return count
//                }
//
         return orderlists.count
        
     }
       
  
    var TickItem: [OrderlistItem] = []
      var Selecttem: [OrderlistItem] = []
    var sum3: Int = 0
    var countarray: Int = 0
    var status: Int = 0
    var sumTickitem: Int = 0
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let cell = tableView.dequeueReusableCell(withIdentifier: "CheckbilllistCell")  as! CheckbilllistTableViewCell
                
        //cell.layer.cornerRadius = 15
        //cell.layer.borderWidth = 2
        if type == "ทั้งหมด" || type == ""{    /////////////////////////////////////////////////////// ///////////////////////////////////////////////////////
              //  Selecttem = orderlistsfoods
            if TickItem.count == 0 {
                   TickItem.append(orderlists[indexPath.row])
                 sum3 += orderlists[indexPath.row].quantity * orderlists[indexPath.row].amount
                   totalPricelbl.text = String(sum3)
 
                   print("Sum ",String(sum3))
             }
             else {
                 for i in TickItem {
                    if i.orderitemid == orderlists[indexPath.row].orderitemid{
                     if let index = TickItem.index(where: {$0.orderitemid == orderlists[indexPath.row].orderitemid}) // Search id = 1 you can set any value
                         {
                         //   sum3 -= orderlists[indexPath.row].quantity * orderlists[indexPath.row].amount
                             
                            
                            sum3 -= orderlists[indexPath.row].quantity * orderlists[indexPath.row].amount
                             
                             TickItem.remove(at: index)
                            
                         
                             
                         }
                         //  totalPricelbl.text = String(sum)
                         print("Delete ",TickItem)
                         
                         status = 1
                         break
                     }
                 }
                 if status == 0 {
                         TickItem.append(orderlists[indexPath.row])
                         print("count  ",TickItem.count)
                         sum3 += orderlists[indexPath.row].quantity * orderlists[indexPath.row].amount
                         totalPricelbl.text = String(sum3)
                         print("Sum ",String(sum3))
                 }
                 
             }
             
        } else if type == "อาหาร"  {     ///////////////////////////////////////////////////////  ///////////////////////////////////////////////////////
                 if TickItem.count == 0 {
                          TickItem.append(orderlistsfoods[indexPath.row])
                        sum3 += orderlistsfoods[indexPath.row].quantity * orderlistsfoods[indexPath.row].amount
                          totalPricelbl.text = String(sum3)
                        
                          print("Sum ",String(sum3))
                    }
                    else {
                        for i in TickItem {
                           if i.orderitemid == orderlistsfoods[indexPath.row].orderitemid{
                            if let index = TickItem.index(where: {$0.orderitemid == orderlistsfoods[indexPath.row].orderitemid}) // Search id = 1 you can set any value
                                {
                                     sum3 -= orderlistsfoods[indexPath.row].quantity * orderlistsfoods[indexPath.row].amount
                              
                                    TickItem.remove(at: index)
                                    
                                }
                                print("Delete ",TickItem)
                                
                                status = 1
                                break
                            }
                        }
                        if status == 0 {
                                TickItem.append(orderlistsfoods[indexPath.row])
                                print("count  ",TickItem.count)
                                sum3 += orderlistsfoods[indexPath.row].quantity * orderlistsfoods[indexPath.row].amount
                                totalPricelbl.text = String(sum3)
                                print("Sum ",String(sum3))
                        }
                        
                    }
        } else  {  ///////////////////////////////////////////////////////  ///////////////////////////////////////////////////////
            if TickItem.count == 0 {
                         TickItem.append(orderlists[indexPath.row])
                       sum3 += orderlistswaters[indexPath.row].quantity * orderlistswaters[indexPath.row].amount
                         totalPricelbl.text = String(sum3)
                       
                         print("Sum ",String(sum3))
                   }
                   else {
                       for i in TickItem {
                          if i.orderitemid == orderlistswaters[indexPath.row].orderitemid{
                           if let index = TickItem.index(where: {$0.orderitemid == orderlistswaters[indexPath.row].orderitemid}) // Search id = 1 you can set any value
                               {
                                    sum3 -= orderlistswaters[indexPath.row].quantity * orderlistswaters[indexPath.row].amount
                             
                                   TickItem.remove(at: index)
                                   
                               }
                               print("Delete ",TickItem)
                               
                               status = 1
                               break
                           }
                       }
                       if status == 0 {
                               TickItem.append(orderlistswaters[indexPath.row])
                               print("count  ",TickItem.count)
                               sum3 += orderlistswaters[indexPath.row].quantity * orderlistswaters[indexPath.row].amount
                               totalPricelbl.text = String(sum3)
                               print("Sum ",String(sum3))
                       }
                       
                   }
        }
        
      //  cell.contentView.backgroundColor = #colorLiteral(red: 0.7559726834, green: 0.8736498356, blue: 0.01575271413, alpha: 1)
        
      /*
        if TickItem.count == 0 {
              TickItem.append(orderlists[indexPath.row])
            sum3 += orderlists[indexPath.row].quantity * orderlists[indexPath.row].amount
              totalPricelbl.text = String(sum3)
            
              print("Sum ",String(sum3))
        }
        else {
            for i in TickItem {
               if i.orderitemid == orderlists[indexPath.row].orderitemid{
                if let index = TickItem.index(where: {$0.orderitemid == orderlists[indexPath.row].orderitemid}) // Search id = 1 you can set any value
                    {
                         sum3 -= orderlists[indexPath.row].quantity * orderlists[indexPath.row].amount
                  
                        TickItem.remove(at: index)
                        
                    }
                    print("Delete ",TickItem)
                    
                    status = 1
                    break
                }
            }
            if status == 0 {
                    TickItem.append(orderlists[indexPath.row])
                    print("count  ",TickItem.count)
                    sum3 += orderlists[indexPath.row].quantity * orderlists[indexPath.row].amount
                    totalPricelbl.text = String(sum3)
                    print("Sum ",String(sum3))
            }
            
        }
        */
     
        status = 0
//
//
//        if TickItem.count == 0  {
//            allbtn.setTitle("selectAll", for: .normal)
//            if type == "ทั้งหมด"{
//                 totalPricelbl.text = String(sum)
//            }else {
//                totalPricelbl.text = String(sum2)
//            }
//
//        }else {
//            totalPricelbl.text = String(sum3)
//        }
//
        if (type == "ทั้งหมด" || type == "") && TickItem.count == orderlists.count {
             allbtn.setTitle("Unselect", for: .normal)
             allbtn.backgroundColor = #colorLiteral(red: 0.9396336079, green: 0.8933145404, blue: 0.1257261634, alpha: 1)
              totalPricelbl.text = String(sum)
        }
         else if (type == "อาหาร" || type == "เครื่องดื่ม") && TickItem.count == count {
            allbtn.setTitle("Unselect", for: .normal)
            allbtn.backgroundColor = #colorLiteral(red: 0.9396336079, green: 0.8933145404, blue: 0.1257261634, alpha: 1)
            totalPricelbl.text = String(sum2)
        } else if TickItem.count == 0 {
             allbtn.setTitle("selectAll", for: .normal)
             allbtn.backgroundColor = #colorLiteral(red: 0.9510123134, green: 0.3623146415, blue: 0.3538915515, alpha: 1)
                sum3 = 0
              totalPricelbl.text = String(sum3)
//        } else if  (type == "อาหาร" || type == "เครื่องดื่ม") && TickItem.count == 0 {
//            allbtn.setTitle("selectAll", for: .normal)
//            totalPricelbl.text = String(sum3)
//        }
        }
            else {
             allbtn.setTitle("selectAll", for: .normal)
              allbtn.backgroundColor = #colorLiteral(red: 0.9510123134, green: 0.3623146415, blue: 0.3538915515, alpha: 1)
              totalPricelbl.text = String(sum3)
        }
//        else {
//            TickItem.append(orderlists[indexPath.row])
//            sum3 += orderlists[indexPath.row].quantity * orderlists[indexPath.row].amount
//            totalPricelbl.text = String(sum3)
//            print("Sum ",String(sum3))
//            countarray = 0
//            tableView.reloadRows(at: [indexPath], with: .none)
//                 tableView.deselectRow(at: [indexPath.row], animated: true)
//        }
//        countarray = countarray+1
        
       tableView.reloadRows(at: [indexPath], with: .none)
        tableView.deselectRow(at: [indexPath.row], animated: false)
        
     
        
        
     
        
           // TickItem.append(orderlists[indexPath.row].foodname)
           // print("Tick ",orderlists[indexPath.row].foodname)
      
        print(indexPath.row," Tick ",TickItem)
            
        
        
    }
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//         //let cell = tableView.dequeueReusableCell(withIdentifier: "CheckbilllistCell")  as! CheckbilllistTableViewCell
   
    //        print("UnTick ",orderlists[indexPath.row].foodname)
//    }
    
    @IBOutlet weak var allbtn: UIButton!
    var countselect: Int = 0
    var sum4: Int = 0
    var sumtotal: Int = 0
    
    @IBAction func All(_ sender: Any) {
          print("Select All",type)
        sumtotal = 0
        TickItem.removeAll()
        
        if countselect == 0 && (type == "ทั้งหมด" || type == ""){
            allbtn.setTitle("Unselect", for: .normal)
             allbtn.backgroundColor = #colorLiteral(red: 0.9396336079, green: 0.8933145404, blue: 0.1257261634, alpha: 1)
              print("sum3 ",sum3)
                sum3 = sum
             totalPricelbl.text = String(sum)
                for i in orderlists {
                    
                    sumtotal += i.amount * i.quantity
                    
                  TickItem.append(i)
                }
                  countselect = 1
            totalPricelbl.text = String(sumtotal)
                  tableView.reloadData()
            
        } else if countselect == 0 && (type == "อาหาร" || type == "เครื่องดื่ม"){
           allbtn.setTitle("Unselect", for: .normal)
             allbtn.backgroundColor = #colorLiteral(red: 0.9396336079, green: 0.8933145404, blue: 0.1257261634, alpha: 1)
//            for i in TickItem {
//                    if i.type == type {
//                        self.sum3 += i.amount * i.quantity
//                }
//            }
            print("sum3 ",sum4)
            totalPricelbl.text = String(sum4)
            
            for i in orderlists {
                if i.type == type {
                    TickItem.append(i)
                }
            }
                countselect = 1
                tableView.reloadData()
        }
        else {
            countselect = 0
            sum3 = 0
              allbtn.backgroundColor = #colorLiteral(red: 0.9510123134, green: 0.3623146415, blue: 0.3538915515, alpha: 1)
            totalPricelbl.text = String(0)
            allbtn.setTitle("selectAll", for: .normal)
            TickItem.removeAll()
            tableView.reloadData()
        }
        
     
        
      
     
        
    }
    
    var checkorder: String = ""
    var sumTotal: Int = 0
     var AllsumTotal: Int = 0
    var nameuser: String = ""
    // let nameuser : String
    

    
    @IBAction func plusbtn(_ sender: UIButton) {
          let button = sender.tag
             let indexPath = NSIndexPath(row:button, section:0)
          //   let cell = tableView.cellForRow(at: indexPath as IndexPath) as! CheckbilllistTableViewCell
        //  self.tableView.reloadData()
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckbilllistCell")  as! CheckbilllistTableViewCell
          var match : Int = 0
         
        print("button ",button)
         
     
        if orderlists[indexPath.row].quantity >= 1  {
                    match = orderlists[indexPath.row].quantity + 1
                   // TickItem[indexPath.row].quantity + 1
            
            //tableView.reloadRows(at: [(indexPath as IndexPath)], with: .none)
                   self.orderlistref.child(orderlists[indexPath.row].orderitemid).updateChildValues(["quantity": match])
        
               //   self.orderlistref.child(checkfoodorderlist[indexPath.row].orderitemid).updateChildValues(["quantity": Int(match)])
            
            
            print("foodname ",orderlists[indexPath.row].foodname)
                 
        }
        
      
    }
    
    @IBAction func minusbtn(_ sender: UIButton) {
        
        let button = sender.tag
                   let indexPath = NSIndexPath(row:button, section:0)
                   let cell = tableView.cellForRow(at: indexPath as IndexPath) as! CheckbilllistTableViewCell
           
                var match : Int = 0
               
               
           
              if orderlists[indexPath.row].quantity > 1  {
                          match = orderlists[indexPath.row].quantity - 1
                          orderlists[indexPath.row].quantity - 1
                          self.orderlistref.child(orderlists[indexPath.row].orderitemid).updateChildValues(["quantity": match])
                     //   self.orderlistref.child(checkfoodorderlist[indexPath.row].orderitemid).updateChildValues(["quantity": Int(match)])
                       
              }
              /*
              else {
                    match = orderlists[indexPath.row].quantity - 1
                    self.orderlistref.child(orderlists[indexPath.row].orderitemid).updateChildValues(["quantity": match])
              }*/
                    
              
    }
    
    var username: String = ""
    var time: String = ""
    
    @IBAction func paybtn(_ sender: Any) {
        
  
        if TickItem.count > 0 {
        
        sumTotal = 0
        AllsumTotal = 0
        
        for i in order{
                username = i.userid
                print("username ",i.userid)
                break
            }
            
         
        
      var date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
       
      
        print("Time ",result)
        
        for j in order{
            for i in TickItem {
                if j.orderid == i.orderid {
                    sumTotal += i.quantity * i.amount
                }
            }
            
            
            
            print(j.orderid," OrderTotal ",sumTotal)
            self.ref.child(j.orderid).updateChildValues(["totalPrice": sumTotal,
                                                         "pay": "yes"])
            AllsumTotal += sumTotal
             print("TotalBill ",AllsumTotal)
            sumTotal = 0
            
        }
         var Billnumber = String(countbill+1)
          
        let billItem = BillItem(totalPrice: AllsumTotal,
                                time: result,
                                userid: username
                                 )


        let billItemRef = self.billref.child(Billnumber)
        billItemRef.setValue(billItem.toAnyObject())

        
        for i in TickItem{
            /*
            for j in order {
                if i.orderid == j.orderid {
                    
                    
                    let orderItem = OrderItem(orderid: j.orderid,
                                              tableid: j.tableid,
                                              totalPrice:  j.totalPrice,
                                              pay: j.pay,
                                              userid: j.userid)
                    let orderItemRef = self.billref.child(Billnumber).child(j.orderid)//.child(type)
                    orderItemRef.setValue(orderItem.toAnyObject())
                    
                
                
                
            
            
            
                  
            }
            }
            */
            
            let orderlistItemRef = self.billref.child(Billnumber).child(i.orderitemid)
            orderlistItemRef.setValue(i.toAnyObject())
            
        }
            
            
            
            
        
            
            
            
            
        
        for i in orderlists{
              self.orderlistref.child(i.orderitemid).updateChildValues(["status": 4])
         }
         
         
        
        
        
          self.tableref.child(table).updateChildValues(["status": "free",
                                                        "statusfood": "free",
                                                        "statuswater": "free",
                                                        "time": result])
        
                 let alert = UIAlertController(title: "เรียบร้อย", message: "ชำระเงินเรียบร้อย", preferredStyle: .alert)
         
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    let payVC = self.storyboard?.instantiateViewController(withIdentifier: "paystoryboardid") as! CheckbilltableViewController
                      self.navigationController?.pushViewController(payVC, animated: false)
                
              }))
            //alert.addAction(cancelAction)
            present(alert, animated: false, completion: nil)
        }
        
//           var text = "Table "+String(tables.count+1)
//
//
//            let key = self.ref.child("Table "+String(tables.count + 1)).childByAutoId().key
//
//              let tableItem = TableItem( name: text,
//                                         key: key!,
//                                         status: "free")
//
//
//              let tableItemRef = self.ref.child("Table "+String(tables.count + 1))
//              tableItemRef.setValue(tableItem.toAnyObject())
//
//
        
       
     //   billref.child
        
//        billref.child("Bill 1").setValue(bill.toA)
//
//            ref.queryOrdered(byChild: "tableid").queryEqual(toValue: table).observeSingleEvent(of: .value, with: { (snapshot) in
//                for child in snapshot.children{
//                    let DataSnap = child as! DataSnapshot
//                    let getid = DataSnap.key
//                    print("childl=key ",getid)
//                    self.ref.child(getid).removeValue()
//                }
//
//            })
        
        
//        tableref.queryOrdered(byChild: "name").queryEqual(toValue: table).observeSingleEvent(of: .value, with: { (snapshot) in
//                    for child in snapshot.children{
//
//                        let snap = child as! DataSnapshot
//                        let key = snap.childSnapshot(forPath: "key") as! NSString
//                        print("childl=key ",key)
//
//                        let tableItem = TableItem( name: self.table,
//                                                   key: key as String,
//                                                   status: false)
//                        let tableItemRef = self.ref.child(self.table)
//                        tableItemRef.setValue(tableItem.toAnyObject())
//
//                    }
//
//        })
        
   /*      if TickItem.count != 0 {
//            let billItem = TableItem( name: text,
//                                                 key: key!,
//                                                 status: "free")
//                  
//                  
//            let tableItemRef = self.ref.child("Table "+String(tables.count + 1))
//            tableItemRef.setValue(tableItem.toAnyObject())
            
      
            
            
            
            
           
            
            var id = "Type "+String(self.categorys.count+1)
             let key = self.ref.child((textField?.text!.lowercased())!).key
            
            let categoryItem = CategoryItem(name: (textField?.text!)!,
                                                           type: "อาหาร",
                                                           status: "off",
                                                           id: id,
                                                           key: key!)
            
            
        }
        tableref.queryOrdered(byChild: "name").queryEqual(toValue: table).observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children{
                
                let DataSnap = child as! DataSnapshot
                let getid = DataSnap.key
                
                print("table id ",getid)
                self.tableref.child(getid).updateChildValues(["status": "free"])
            }
            
        })
        
        
        
        
        
          ref.removeValue()
        
        let alertController = UIAlertController(
            title: "ชำระเงิน", message: "ลูกค้าชำระเงินเรียบร้อย!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(
            title: "ตกลง", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        payment.removeAll()
        
        self.tableView.reloadData()
        
        present(alertController, animated: false, completion: nil)
                
 */
    }
 
    
}
