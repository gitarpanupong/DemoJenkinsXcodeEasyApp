//
//  CustomercategoryViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 5/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class CustomercategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var controlsegment: UISegmentedControl!
    
    var categorys: [CategoryItem] = []
    var count : Int = 0
    var tablenum : String = ""
    var tablekey : String = ""
    var orderfood = [[String:AnyObject]]()
    
     let reffood = Database.database().reference(withPath: "Food-items")
       let refwater = Database.database().reference(withPath: "Water-items")
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomercategoryTableViewCell")  as! CustomercategoryTableViewCell
        
        var categoryItem = categorys[indexPath.row]
        
        cell.categorylbl.text = categoryItem.name
        
        
        return cell
    }
    
    var press = [Int]()
    
    @IBOutlet weak var tableView: UITableView!
    var type : String = ""
    var typeref : AnyObject?
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            let orderFood = segue.destination as? showOrderViewController
        orderFood?.orderfoodName = orderfood
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if count == 0 {
             type = "อาหาร"
            typeref = reffood
            print("ประเภท ",type)
        }
        else {
            type = "เครื่องดื่ม"
             typeref = refwater
            print("ประเภท ",type)
        }
        var newCategory: [CategoryItem] = []
        
        typeref?.queryOrdered(byChild: "name").observe(.value, with: { snapshot in
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print("eiei")
        let showCategory = storyboard?.instantiateViewController(withIdentifier: "showorderfood") as! showOrderViewController
        
        showCategory.categoryName = categorys[indexPath.row].name
        showCategory.tablenum = tablenum
        showCategory.type = type
        showCategory.typeref = typeref
        showCategory.press = press
        showCategory.orderfoodName = orderfood
        showCategory.tablekey = tablekey
        
        self.navigationController?.pushViewController(showCategory, animated: true)
    }
    
    @IBAction func recurranceChanged(_ sender: UISegmentedControl) {
        
        
        print("index : ",sender.selectedSegmentIndex)
        
        
        if sender.selectedSegmentIndex == 0 {
            count = 0
            self.viewDidLoad()
            print(count)
        }
        if sender.selectedSegmentIndex == 1 {
            count = 1
            self.viewDidLoad()
            print(count)
        }
        
        
    }
    
    
    
}
