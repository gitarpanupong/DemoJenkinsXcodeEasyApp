//
//  showOrderViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 2/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit

import FirebaseDatabase
import FirebaseStorage

class showOrderViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableview: UITableView!
   // var orderfoodName:[String] = []
    var categoryName : String!
    
    var orderfoodName = [[String:AnyObject]]()
    
    var foods: [FoodItem] = []
    var tablenum: String = ""
     var tablekey : String = ""
     var waters: [WaterItem] = []
    var select: [AnyObject] = []
    
    
    let reforder = Database.database().reference(withPath: "Order-items")
     let ref = Database.database().reference(withPath: "Food-items")
     let reffood = Database.database().reference(withPath: "Food-items")
     let refwater = Database.database().reference(withPath: "Water-items")
    
    var stringsum : String!
    var sum : Int!
    var allsum : Int! = 0
    
    var press =  Array(repeating: 1, count: 0)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == "อาหาร" {
            return foods.count
        } else {
            return waters.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ShowOrderTableViewCell") as! ShowOrderTableViewCell
if type == "อาหาร" {
        press =  Array(repeating: 0, count: foods.count)
        //let cell = tableView.dequeueReusableCell(withIdentifier: "ShowOrderTableViewCell") as! ShowOrderTableViewCell
         let ref = Database.database().reference(withPath: "Food-items")
        let foodItem = foods[indexPath.row]
        cell.lblFoodName?.text = foodItem.name
        cell.lblFoodPrice?.text = foodItem.price
        
        let imageRef = Storage.storage().reference().child("Food").child(foodItem.name.lowercased()+".jpg")
        imageRef.getData(maxSize: 100*1024*1024, completion: { (data, error) -> Void  in
            if error == nil {
                print("Data")
                print(data)
                cell.imageViewFood?.image = UIImage(data: data!)
            } else {
                print("error")
                print(error?.localizedDescription)
            }
            
        })
}
else{
    press =  Array(repeating: 0, count: waters.count)
    let ref = Database.database().reference(withPath: "Water-items")
    let waterItem = waters[indexPath.row]
    cell.lblFoodName?.text = waterItem.name
    cell.lblFoodPrice?.text = waterItem.price
    
    let imageRef = Storage.storage().reference().child("Water").child(waterItem.name.lowercased()+".jpg")
    imageRef.getData(maxSize: 100*1024*1024, completion: { (data, error) -> Void  in
        if error == nil {
            print("Data")
            print(data)
            cell.imageViewFood?.image = UIImage(data: data!)
        } else {
            print("error")
            print(error?.localizedDescription)
        }
        
    })
}
        
       
        for name1 in orderfoodName
        {
            if name1["ชื่อ"] as! String ==  cell.lblFoodName.text {
                 cell.addCart.setTitle("ยกเลิก", for: .normal)
                press[indexPath.row] = 1 //ทีเด็ด
                for item in orderfoodName as! [[String: AnyObject]] {
                    stringsum = item["ราคา"] as! String?
                    count = 1
                    sum = Int(stringsum)
                    allsum += sum
                }
            }
        }
        
        cell.addCart.tag = indexPath.row
        cell.addCart.addTarget([indexPath], action: #selector(addcartTapped(_:)), for: .touchUpInside)
        
        
        return cell
    }
   
    var count : Int = 0
   
    @objc func addcartTapped(_ sender: UIButton){
        
         var index = sender.tag

        print("กด ",press[index])
        let indexPath = NSIndexPath(row:index, section:0)
        let cell = tableview.cellForRow(at: indexPath as IndexPath) as! ShowOrderTableViewCell
        
        if press[index] == 0 {
            press[index] += 1
           if type == "อาหาร" {
            orderfoodName.append(["ชื่อ": foods[index].name as AnyObject,"ราคา": foods[index].price as AnyObject,"จำนวน": 1 as AnyObject])
            }
           else {
             orderfoodName.append(["ชื่อ": waters[index].name as AnyObject,"ราคา": waters[index].price as AnyObject,"จำนวน": 1 as AnyObject])
            }
            allsum = 0
            
            for item in orderfoodName as! [[String: AnyObject]] {
                stringsum = item["ราคา"] as! String?
                
                sum = Int(stringsum)
                allsum += sum
            }
            
           print("รวม ",allsum)
            cell.addCart.setTitle("ยกเลิก", for: .normal)
            
        } else if press[index] == 1{
            press[index] -= 1
            var curIndex = -1
            var search = cell.lblFoodName.text
            
            for name1 in orderfoodName
            {
                 curIndex += 1
                if name1["ชื่อ"] as! String == search {
                     stringsum = name1["ราคา"] as! String?
                      sum = Int(stringsum)
                    allsum -= sum
                    print("Match ")
                    print(curIndex)
                    orderfoodName.remove(at: curIndex)
                    break
                }
            }
         
            print("รวม ",allsum)
            curIndex = -1
           
            cell.addCart.setTitle("เพิ่ม", for: .normal)
        }
            }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "GoToOrderViewController"{
      
      let orderFood = segue.destination as? OrderViewController
        orderFood?.orderfood = orderfoodName
        orderFood?.sum = allsum
        orderFood!.tablenum = tablenum
        orderFood?.categoryName = categoryName
        orderFood?.type = type
        orderFood?.typeref = typeref!
        orderFood?.tablekey = tablekey
        orderFood?.press = press
       print("โต๊ะ ",tablekey)
        print(allsum)
         print("AddCart")
        }
        else if segue.identifier == "GoTocategory"{
           let orderFood = segue.destination as? CustomercategoryViewController
              orderFood?.orderfood = orderfoodName
                orderFood?.press = press
                orderFood?.tablekey = tablekey
                orderFood?.tablenum = tablenum
        }
    }
    
    var type : String = ""
    var typeref : AnyObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if  type == "อาหาร" {
            typeref = reffood
            typeref?.child(categoryName).queryOrdered(byChild: "Water").observe(.value, with: { snapshot in
                var newFoods: [FoodItem] = []
                for child in snapshot.children {

                    if let snapshot = child as? DataSnapshot,
                        let foodItem = FoodItem(snapshot: snapshot) {
                        newFoods.append(foodItem)
                    }
                }
                self.foods = newFoods
                self.tableview.reloadData()
            })
            print("ประเภท ",type)
        }
        else if type == "เครื่องดื่ม" {
            typeref = refwater
            refwater.child(categoryName).queryOrdered(byChild: "Water").observe(.value, with: { snapshot in
                var newWaters: [WaterItem] = []
                for child in snapshot.children {
                    
                    if let snapshot = child as? DataSnapshot,
                        let waterItem = WaterItem(snapshot: snapshot) {
                        newWaters.append(waterItem)
                    }
                }
                self.waters = newWaters
                self.tableview.reloadData()
            })
            print("ประเภท ",type)
        }
        
     
        
  

       
    }

    
}

