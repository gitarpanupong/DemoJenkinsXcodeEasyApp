//
//  CategoryWaterViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 7/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CategoryWaterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var categorys: [CategoryItem] = []
    
    var refCategorys: DatabaseReference!
    
    let ref = Database.database().reference(withPath: "Category-items")
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var OpenMenu: UIBarButtonItem!
    
    func order(){
        ref.child("เครื่องดื่ม").queryOrdered(byChild: "name").observe(.value, with: { snapshot in
                var newCategorys: [CategoryItem] = []
                    for child in snapshot.children {
                        if let snapshot = child as? DataSnapshot,
                            let categoryItem = CategoryItem(snapshot: snapshot) {
                            newCategorys.append(categoryItem)
                           
                        }
                    }
                    self.categorys = newCategorys
                    self.tableView.reloadData()
                    
                })
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            OpenMenu.target = self.revealViewController()
            OpenMenu.action = Selector("revealToggle:")
        
        print("eiei")
              tableView.rowHeight = 40
            
        order()
        // Do any additional setup after loading the view.
    }
    

  
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .none {
//            let categoryItem = categorys[indexPath.row]
//           // self.ref.child(categoryItem.name).updateChildValues(["status": "off"])
//            print("เปิดแล้ววว")
//          //  categoryItem.ref?.removeValue()
//        }
//
//
//    }
    
    var namestatus: String?
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryWaterCell", for: indexPath)
        let categoryItem = categorys[indexPath.row]
        
        cell.textLabel?.text = categoryItem.name
        
        if categoryItem.status == "off" {
            cell.contentView.alpha = 0.4
             cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else {
              cell.contentView.alpha = 1
        }

          cell.textLabel?.textAlignment = .center
          cell.textLabel?.adjustsFontSizeToFitWidth = true
         // cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 30.0)
          //cell.layer.borderWidth = 8
         // cell.layer.borderColor = UIColor(red:29/255, green:30/255, blue:32/255, alpha: 1).cgColor
         // cell.layer.borderColor = UIColor(red:0/255, green:0/255, blue:0/255, alpha: 1).cgColor
          //cell.layer.cornerRadius = view.frame.size.width/6.0
          cell.layer.masksToBounds = false
         // cell.layer.cornerRadius = 15
        
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
               cell.layer.borderWidth = 1
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showCategory = storyboard?.instantiateViewController(withIdentifier: "showwater") as! WaterViewController
        
        showCategory.categoryName = categorys[indexPath.row].name
        showCategory.categoryID = categorys[indexPath.row].id
        
        self.navigationController?.pushViewController(showCategory, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
         if self.categorys[indexPath.row].status == "off"{
             namestatus = "on"
         }else {
             namestatus = "off"
         }
         
         let statusButton = UITableViewRowAction(style: .default, title: namestatus) { (action, indexPath) in
             let categoryItem = self.categorys[indexPath.row]
             self.ref.child("เครื่องดื่ม").child(categoryItem.name).updateChildValues(["status": self.namestatus])
             tableView.reloadRows(at: [indexPath], with: .none)
             print("Opennnn ",self.namestatus)
         }
            
        let editbutton = UITableViewRowAction(style: .default, title: "แก้ไขชื่อ") { (action, indexPath) in
                  
                 self.update(row: indexPath)
            
              }
                editbutton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
         statusButton.backgroundColor = #colorLiteral(red: 0.9396336079, green: 0.8933145404, blue: 0.1257261634, alpha: 1)
         return [statusButton,editbutton]
     }
    
    var id: String?
     var match: Int?
    
    @IBAction func onAddTapped(_ sender: Any) {
      
        let alert = UIAlertController(title: "Add Category", message: nil, preferredStyle: .alert)

      /*
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textField = alert.textFields?.first,
                let text = textField.text else { return }


            let key = self.ref.child(text.lowercased()).key
            
               var id = "Type "+String(self.categorys.count + 1)

            let categoryItem = CategoryItem(name: text,
                                            type: "เครื่องดื่ม",
                                            status: "off",
                                             id: id,
                                            key: key!)

            let categoryItemRef = self.ref.child("เครื่องดื่ม").child(text.lowercased())
            categoryItemRef.setValue(categoryItem.toAnyObject())
        }

        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
     
        alert.addTextField()
       alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
        */
        
          let alert2 = UIAlertController(title: "ลองใหม่อีกครั้ง", message: "ข้อมูลไม่ถูกต้อง", preferredStyle: .alert)
        
           let alert3 = UIAlertController(title: "เพิ่มข้อมูลเรียบร้อย", message: nil, preferredStyle: .alert)
          let cancelAction = UIAlertAction(title: "Cancel",
                                                style: .cancel)
          let OkAction = UIAlertAction(title: "Ok",
                                                     style: .cancel)
          
          alert.addTextField { (textField) in
              textField.text = ""
          }
          
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
              let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
             
              switch Int((textField?.text!)!) {
                     case nil:
                           for i in self.categorys {
                           // if i.type == "เครื่องดื่ม" {
                                       if i.name == textField?.text {
                                           self.match = 1
                                           break
                                       } else {
                                         //  print("Text field: \(name)")
                                           self.match = 0
                                       }
                                }
                           // }
                     default:
                         self.match = 1
                     }

          
              
              if self.match == 1 || (textField!.text == "") {
                    self.present(alert2, animated: true, completion: nil)
              }else {
                var id = "Type "+String(self.categorys.count+1)
                               
                              let key = self.ref.child((textField?.text!.lowercased())!).key
                               
                              let categoryItem = CategoryItem(name: textField!.text!,
                                                               type: "เครื่องดื่ม",
                                                               status: "on",
                                                               id: id,
                                                               key: key!)
                              let categoryItemRef = self.ref.child("เครื่องดื่ม").child(textField!.text!.lowercased())
                                categoryItemRef.setValue(categoryItem.toAnyObject())
                   self.present(alert3, animated: true, completion: nil)
              }

             
          }))
          
           alert3.addAction(OkAction)
           alert2.addAction(OkAction)
           alert.addAction(cancelAction)
           present(alert, animated: true, completion: nil)
          

    }
    
    func update(row: IndexPath){
              let alert = UIAlertController(title: "Edit Category", message: nil, preferredStyle: .alert)
             
                   let alert2 = UIAlertController(title: "ลองใหม่อีกครั้ง", message: "ข้อมูลไม่ถูกต้อง", preferredStyle: .alert)
                 
                    let alert3 = UIAlertController(title: "แก้ไขเรียบร้อย", message: nil, preferredStyle: .alert)
                   let cancelAction = UIAlertAction(title: "Cancel",
                                                         style: .cancel)
                   let OkAction = UIAlertAction(title: "Ok",
                                                              style: .cancel)
                   
                   alert.addTextField { (textField) in
                       textField.text = ""
                   }
                   
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                       let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                      
                       switch Int((textField?.text!)!) {
                              case nil:
                                    for i in self.categorys {
                                                if i.name == textField?.text {
                                                    self.match = 1
                                                    break
                                                } else {
                                                  //  print("Text field: \(name)")
                                                    self.match = 0
                                                }
                                                              
                                            }
                              default:
                                  self.match = 1
                              }

                   
                       
                       if self.match == 1 || (textField!.text == "") {
                             self.present(alert2, animated: true, completion: nil)
                       }else {
                        let categoryItem = CategoryItem(name: textField!.text!,
                                                                                    type: "เครื่องดื่ม",
                                                                                    status: "on",
                                                                                    id: self.categorys[row.row].id,
                                                                                    key: textField!.text!)
                                     let categoryItemRef = self.ref.child("เครื่องดื่ม").child(textField!.text!.lowercased())
                                     categoryItemRef.setValue(categoryItem.toAnyObject())
                                     
                                     self.ref.child("เครื่องดื่ม").child(self.categorys[row.row].key).removeValue()
                                     
                            self.present(alert3, animated: true, completion: nil)
                       }
                           
                       self.tableView.reloadRows(at: [row], with: .none)
                      
                   }))
                   
                    alert3.addAction(OkAction)
                    alert2.addAction(OkAction)
                    alert.addAction(cancelAction)
                    present(alert, animated: true, completion: nil)
                   
           
       }
       
    

}
