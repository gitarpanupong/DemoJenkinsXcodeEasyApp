//
//  CheckbilltableViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 6/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class CheckbilltableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

      let ref = Database.database().reference(withPath: "Table-items")

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var OpenMenu: UIBarButtonItem!
    
    func call(){
        ref.queryOrdered(byChild: "status").queryEqual(toValue: "call").observe(.value, with: { (snapshot: DataSnapshot!) in //.observeSingleEvent(of: .value, with: { (snapshot) in
            var newTables: [TableItem] = []
               for child in snapshot.children {
                   if let snapshot = child as? DataSnapshot,
                       let tableItem = TableItem(snapshot: snapshot) {
                       newTables.append(tableItem)
                       
                           }
                       }
                     self.tables = newTables
                         DispatchQueue.main.async {
                           
                            self.tableView.reloadData()
                        }
                       
                   })
    }
    
    
     var payment: [OrderlistItem] = []
    var tables: [TableItem] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            
          
            
            
             OpenMenu.target = self.revealViewController()
             OpenMenu.action = Selector("revealToggle:")
            
           tableView.dataSource = self
              tableView.delegate = self
                        
               call()
              
                              
            
        }
    
    override func viewWillAppear(_ animated: Bool) {
//         DispatchQueue.main.async {
//            print("kuy ")
//                                 self.tableView.reloadData()
//        }
    }
    

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tables.count == 0{
       return 1
    }
    else{
        return tables.count
    }
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CheckbilltableCell") as! CheckbilltableTableViewCell
    cell.layer.borderWidth = 2
    cell.layer.cornerRadius = 15
     
    if tables.count == 0 {
        cell.textLabel?.text = "ไม่มีรายการชำระเงิน"
       
        cell.backgroundColor = #colorLiteral(red: 0.7559726834, green: 0.8736498356, blue: 0.01575271413, alpha: 1)
        //cell.textLabel?.backgroundColor = UIColor.green
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.textAlignment = .center
//        cell.textLabel?.layer.cornerRadius = 15
//        cell.textLabel?.layer.borderWidth = 3
    }else {
        let tableItem = tables[indexPath.row]
        cell.textLabel?.text = tableItem.name
        cell.backgroundColor = #colorLiteral(red: 0.9510123134, green: 0.3623146415, blue: 0.3538915515, alpha: 1)
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.textAlignment = .center
           // cell.textLabel?.textAlignment = .center
    }
   
    
    
    return cell
}

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
          let checkbillFood = storyboard?.instantiateViewController(withIdentifier: "Checkbilllist") as! CheckbilllistViewController
        
      //  var statusItem = status[indexPath.row]
        if tables.count == 0{
            print("Nothing")
              tableView.deselectRow(at: indexPath, animated: true)
        }else{
              tableView.deselectRow(at: indexPath, animated: true)
            let tableItem = tables[indexPath.row]
             checkbillFood.table = tableItem.name
             self.navigationController?.pushViewController(checkbillFood, animated: false)
        }
    }

}
