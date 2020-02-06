//
//  SelectTableViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 7/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SelectTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
       var tables: [TableItem] = []
    var status: String!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return tables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cutomershowtablecell", for: indexPath) as! SelecttableTableViewCell
        
          let tableItem = tables[indexPath.row]
        print("table item ",tableItem)
        
        cell.tablenamelbl.text = tableItem.name
        
        if tableItem.status == "free" {
            status = "ว่าง"
            cell.tablestatuslbl.text = status
            cell.tablestatuslbl.textColor = UIColor.green
        }
        else if tableItem.status == "busy" {
            status = "สั่งอาหารแล้ว"
            cell.tablestatuslbl.text = status
            cell.tablestatuslbl.textColor = UIColor.red
        }
        else if tableItem.status == "call" {
            status = "รอชำระเงิน"
            cell.tablestatuslbl.text = status
            cell.tablestatuslbl.textColor = UIColor.blue
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showtableFood = storyboard?.instantiateViewController(withIdentifier: "showcategoryfood") as! CustomercategoryViewController
        
        showtableFood.tablenum = tables[indexPath.row].name
          showtableFood.tablekey = tables[indexPath.row].key
        self.navigationController?.pushViewController(showtableFood, animated: true)
        print("โต๊ะ ",tables[indexPath.row])
        
    }
    
    @IBOutlet weak var tableView: UITableView!
     let ref = Database.database().reference(withPath: "Table-items")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.queryOrdered(byChild: "name").observe(.value, with: { snapshot in
            var newTables: [TableItem] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let tableItem = TableItem(snapshot: snapshot) {
                    newTables.append(tableItem)
                }
            }
            
            self.tables = newTables
            self.tableView.reloadData()
            
        })
    }

}
