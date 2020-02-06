//
//  HistoryDetailViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 14/11/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class HistoryDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    @IBOutlet weak var foodnamelbl: UITableView!
    @IBOutlet weak var foodsumlbl: UILabel!
    var getsum: Int = 0
    var getbill: String?
      let ref = Database.database().reference(withPath: "Bill-items")
    var orderlists: [OrderlistItem] = []
    @IBOutlet weak var tableView: UITableView!
    
    func orderlist(){
        
        ref.child(getbill!).observe(.value, with: { snapshot in
               var newOrderlists: [OrderlistItem] = []
               for child in snapshot.children {
                   if let snapshot = child as? DataSnapshot,
                       let orderlistItem = OrderlistItem(snapshot: snapshot) {
                       newOrderlists.append(orderlistItem)
                   }
               }
               self.orderlists = newOrderlists
                self.tableView.reloadData()
           })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderlist()
        foodsumlbl.text = String(getsum)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderlists.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "historydetail") as! HistoryDetailTableViewCell

        let orderlistrow = orderlists[indexPath.row]
        cell.foodnamelbl.text = orderlistrow.foodname
        cell.foodpricelbl.text = String(orderlistrow.amount)
        cell.foodquantitylbl.text = String(orderlistrow.quantity)
        return cell
     }
     

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
