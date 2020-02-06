//
//  OrderViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 2/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class OrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet weak var sumlbl: UILabel!
    
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    var type : String = ""
    var typeref : AnyObject?
      var press =  Array(repeating: 1, count: 0)
    
    
    var foods: [FoodItem] = []
     var orderfood = [[String:AnyObject]]()
    var categoryName : String!
    var name : String!
    var price : String!
    var sum : Int!
    var sum2 : Int!
    var allsum : Int! = 0
    var stringsum : String!
    var tablenum : String = ""
    var tablekey : String = ""

    var sum1 = Array(repeating: 1, count: 0)
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let orderFood = segue.destination as? showOrderViewController
//
//        orderFood?.orderfoodName = orderfood
//    }
//
//
    
     var countorder: Int = 0
    var countwater: Int = 0
    var countfood: Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return orderfood.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell

        
        cell.foodNamelbl.text = orderfood[indexPath.row]["ชื่อ"] as! String
        cell.foodPricelbl.text = orderfood[indexPath.row]["ราคา"] as! String
        
        cell.stepper.tag = indexPath.row
        cell.stepper.addTarget(self, action: #selector(stepperAction(sender:)), for: .valueChanged)

        return cell
    }
    
    var count: Int = 0
    
    @objc func stepperAction(sender: UIStepper) {
        let button = sender.tag
       // let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell") as! OrderTableViewCell
       
        let indexPath = NSIndexPath(row:button, section:0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! OrderTableViewCell
         let value = Int(sender.value)
        var value2 = Int(sender.value)
      
        //sum1[button] = Int(orderfood[indexPath.row]["ราคา"]! as! String)!
        sum1[button] = Int(orderfood[indexPath.row]["ราคา"]! as! String)! * value
        print("sum1 ",sum1[indexPath.row])
        
        allsum = 0
        for item in sum1  {
           //stringsum = sum1[item]
           print("item",item)
            allsum += item
           
        }
        
        print("allsum = ",allsum)
        
        sumlbl.text = String(allsum)
        
        var search = cell.foodNamelbl.text
        for var amount in orderfood
        {
            if amount["ชื่อ"] as! String == search{
             //   amount["จำนวน"] = value2 as Int? as AnyObject?
                orderfood[indexPath.row]["จำนวน"] = value2 as AnyObject
                print(orderfood)
            }
            count += 1
        }
        cell.amountlbl.text = String(value)
        
    }
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.observe(.value, with: { (snapshot: DataSnapshot!) in
            self.countorder = Int(snapshot.childrenCount)
            print("จำนวออเดอร์ ",snapshot.childrenCount)
        })
       
        
        sum1 = Array(repeating: 1, count: orderfood.count)
        var i = 0
        for item in sum1  {
            //stringsum = sum1[item]
            
            sum1[i] = Int(orderfood[i]["ราคา"]! as! String)!
            i=i+1
        }
        
          print("orderfood ",orderfood.count)
       sumlbl.text = String(sum)
        // Do any additional setup after loading the view.
    }
    
    
    let ref = Database.database().reference(withPath: "Order-items")
     let foodref = Database.database().reference(withPath: "Food-items")
      let waterref = Database.database().reference(withPath: "Water-items")
        let tableref = Database.database().reference(withPath: "Table-items")

    @IBAction func confirmData(_ sender: Any) {
 
        var keyfoodid: String = ""
        print("sum = ",sum)
        
        let userid : String = (Auth.auth().currentUser?.uid)!
        print(userid)
        
        let orderItem = OrderItem(orderid: "Order "+String(self.countorder+1),
                                tableid: tablekey,
                                 totalPrice:  Int(sumlbl!.text!)!,
                                 pay: "no",
                                 userid: userid)
        let orderItemRef = self.ref.child("Order "+String(self.countorder+1))//.child(type)
        orderItemRef.setValue(orderItem.toAnyObject())

            for name in orderfood{
                if name["จำนวน"] as! Int == 0{
                    
                    orderfood.remove(at: count)
                    print(orderfood)
                }
                count += 1
            }
        

         for name in orderfood{
            foodref.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
              
                 for child in snapshot.children{
                    let DataSnap = child as! DataSnapshot
                    let getid = DataSnap.key //the uid of each user
                    
                    self.foodref.child(getid).queryOrdered(byChild: "name").queryEqual(toValue: name["ชื่อ"]).observeSingleEvent(of: .value, with: { (snapshot) in
                        
                            for child in snapshot.children{
                                
                                self.countfood = self.countfood + 1
                                
                                print("จำนวนรายการอาหาร ",self.countfood)
                                
                                
                                keyfoodid = (child as AnyObject).key as String
                                var keyorderid: String = ""
                                let orderlistItem = OrderlistItem(orderitemid: "OrderFood "+String(self.countfood),
                                                                    foodid: keyfoodid,
                                                                  foodname: name["ชื่อ"] as! String,
                                                                  type: "อาหาร" ,
                                                                  orderid: "Order "+String(self.countorder),
                                                                    quantity: name["จำนวน"] as! Int,
                                                                    amount: Int(name["ราคา"]  as! String)!,
                                                                    status: 0)
                                
                                let orderlistItemRef = orderItemRef.child("อาหาร").child("OrderFood "+String(self.countfood))
                                orderlistItemRef.setValue(orderlistItem.toAnyObject())
                                
                            }
                        })
                    
                }
                
            }else{
                print("ไม่เจออาหาร")
                
                return
            }
        })
            
            waterref.observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.exists() {
                    
                    for child in snapshot.children{
                        let DataSnap = child as! DataSnapshot
                        let getid = DataSnap.key //the uid of each user
                        
                      
                        
                        self.waterref.child(getid).queryOrdered(byChild: "name").queryEqual(toValue: name["ชื่อ"]).observeSingleEvent(of: .value, with: { (snapshot) in
                          
                            
                            
                            for child in snapshot.children{
                                self.countwater = self.countwater + 1
                                
                                print("จำนวนรายการน้ำ ",self.countwater)
                               
                                keyfoodid = (child as AnyObject).key as String
                                var keyorderid: String = ""
                                
                                let orderlistItem = OrderlistItem(orderitemid: "OrderWater "+String(self.countwater),
                                                                  foodid: keyfoodid,
                                                                  foodname: name["ชื่อ"] as! String,
                                                                  type: "เครื่องดื่ม" ,
                                                                  orderid: "Order "+String(self.countorder),
                                                                  quantity: name["จำนวน"] as! Int,
                                                                  amount: Int(name["ราคา"]  as! String)!,
                                                                  status: 0)
                                
                                let orderlistItemRef = orderItemRef.child("เครื่องดื่ม").child("OrderWater "+String(self.countwater))
                                orderlistItemRef.setValue(orderlistItem.toAnyObject())
                                
                            }
                        })
                        
                    }
                    
                }else{
                    print("ไม่เจอน้ำ")
                    
                    return
                }
            })
        }
        
        
//        for name in orderfood{
//
//            foodref.child(categoryName).queryOrdered(byChild: "name").queryEqual(toValue: name["ชื่อ"]).observeSingleEvent(of: .value, with: { (snapshot) in
//
//                if snapshot.exists() {
//
//                    for child in snapshot.children{
//                        keyfoodid = (child as AnyObject).key as String
//                        var keyorderid: String = ""
//                        let orderlistItem = OrderlistItem(foodid: keyfoodid,
//                                                        foodname: name["ชื่อ"] as! String,
//                                                          quantity: name["จำนวน"] as! Int,
//                                                          amount: Int(name["ราคา"]  as! String)!,
//                                                          status: 0)
//
//                        let orderlistItemRef = orderItemRef.child("อาหาร").childByAutoId()
//                        orderlistItemRef.setValue(orderlistItem.toAnyObject())
//
//                    }
//
//                }else{
//                    print("User doesn't exist")
//
//                    return
//                }
//            })
//        }
        
        tableref.child(tablenum).updateChildValues(["status" : "busy"])
        
        
        
        let alertController = UIAlertController(
            title: "สั่งอาหารเรียบร้อยแล้ว", message: "กรุณารออาหารสักครู่!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(
            title: "ตกลง", style: .default, handler: nil)
        alertController.addAction(defaultAction)
     
        orderfood.removeAll()
//        navigationController?.popViewController(animated: true)
        
        press.removeAll()
//
        self.tableView.reloadData()
//        let CustomercategoryViewController = self.navigationController?.topViewController as? CustomercategoryViewController
//        CustomercategoryViewController?.tableView?.reloadData()
        present(alertController, animated: true, completion: nil)
  
  
        
        print("Save")
    }
    
        
    }

    


