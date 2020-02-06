//
//  WaterViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 26/7/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class WaterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var OpenMenu: UIBarButtonItem!
    
    var categoryName : String!
    var categoryID : String!
    var waterimages : NSURL!
    var newWater = Water()
    
    var waters: [WaterItem] = []
      var extras: [ExtraItem] = []
    
      let ref = Database.database().reference(withPath: "Food-items")
    
    var checkex = [[String]]()
    
    func getextra() {
        checkex.removeAll()
        for i in waters {
                self.ref.child("เครื่องดื่ม").child(i.waterid).observe(.value, with: { snapshot in
                    var newExtras: [ExtraItem] = []
            
                            for child in snapshot.children {
                             //     print("child ",child)
                                if let snapshot = child as? DataSnapshot,
                                    let extraItem = ExtraItem(snapshot: snapshot) {
                                   
                                    self.checkex.append([i.waterid,extraItem.name])
                                   
                                   
                                    newExtras.append(extraItem)
                                    
                                    
            }
              }
                    self.extras = newExtras
                    
                    
                  //  print("kaaaa ",self.extras)
                    self.waters.sort { $0.name < $1.name}
                         self.tableView.reloadData()
             
                  
          })
                
        
                
            }
    }
    
    
//    func checkextra(){
//        for i in extras {
//
//
//              print("extras ",i)
//
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //OpenMenu.target = self.revealViewController()
       // OpenMenu.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
      
        
        
        
        ref.child("เครื่องดื่ม").queryOrdered(byChild: "idcategory").queryEqual(toValue: categoryID).observe(.value, with: { snapshot in
            var newWaters: [WaterItem] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let waterItem = WaterItem(snapshot: snapshot) {

                    newWaters.append(waterItem)
                }
            }
            self.waters = newWaters
            self.getextra()
          //  self.tableView.reloadData()
        })
        
    
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waters.count
    }
    var checkextra =  [String]()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WaterTableCell") as! WaterTableViewCell
       
        let waterItem = waters[indexPath.row]
        
        checkextra.removeAll()
        for i in checkex {
            print("laa ",i[0])
            if i[0] == waterItem.waterid {
              //  print(waterItem.name," i ",i[1])
                checkextra.append(i[1])
                //waterextralbl
            }
        }
        
     //   print(waterItem.name," ",checkextra)
         
        cell.waterextralbl.text = checkextra.joined(separator:"-")
        
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 3
        cell.imageViewWater.layer.borderWidth = 3
        cell.imageViewWater.layer.cornerRadius = 15
        cell.imageViewWater.layer.borderColor = UIColor(red: 235/255, green: 70/255, blue: 74/255, alpha: 1).cgColor
         cell.layer.borderColor = UIColor(red: 29/255, green: 30/255, blue: 32/255, alpha: 1).cgColor
        
        let water: WaterItem
//        if isFiltering() {
//            water = filteredwaters[indexPath.row]
//        } else {
//            water = waters[indexPath.row]
//        }
        
        if waterItem.status == "off" {
            cell.contentView.alpha = 0.4
        }else {
            cell.contentView.alpha = 1
        }
        
        cell.lblWaterName?.text = waterItem.name
       cell.lblWaterPrice?.text = waterItem.price
      //   cell.lblWaterPrice?.text = "               "
        
        let imageRef = Storage.storage().reference().child("Water").child(waterItem.name.lowercased()+".jpg")
        imageRef.getData(maxSize: 100*1024*1024, completion: { (data, error) -> Void  in
            
            if error == nil {
                print("Data")
                print(data)
                cell.imageViewWater.image = UIImage(data: data!)
                
                //print(error?.localizedDescription)
                
            } else {
                
                print("error")
                //  print(data)
                print(error?.localizedDescription)
                
            }
            
        })
        
        return cell
    }
    //Delete + update Cell

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  let showFood = storyboard?.instantiateInitialViewController(withIdentifier: "show") as! DetailFoodViewController
        
        var showFood = storyboard?.instantiateViewController(withIdentifier: "show2") as! DetailWaterViewController
        
        showFood.name =  waters[indexPath.row].name
        showFood.price = waters[indexPath.row].price
        showFood.img = waters[indexPath.row].waterimage
        showFood.waterid = waters[indexPath.row].key
        showFood.category = categoryName
        
        self.navigationController?.pushViewController(showFood, animated: false)
        
        
        //   self.present(showFood, animated: true, completion: nil)
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let waterItem = waters[indexPath.row]
//            waterItem.ref?.removeValue()
//        }
//    }
        var namestatus: String?
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
         if self.waters[indexPath.row].status == "off"{
             namestatus = "on"
         }else {
             namestatus = "off"
         }
         
         let statusButton = UITableViewRowAction(style: .default, title: namestatus) { (action, indexPath) in
             let waterItem = self.waters[indexPath.row]
            self.ref.child("เครื่องดื่ม").child(waterItem.waterid).updateChildValues(["status": self.namestatus])
             tableView.reloadRows(at: [indexPath], with: .none)
             print("Opennnn ",self.namestatus)
         }

         statusButton.backgroundColor = #colorLiteral(red: 0.9396336079, green: 0.8933145404, blue: 0.1257261634, alpha: 1)
         return [statusButton]
     }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newwater = segue.destination as? WaterNewViewController
       
        newwater?.category = categoryName
        newwater?.categoryID = categoryID
        newwater?.countwater = waters.count
    }
    

}
