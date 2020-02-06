//
//  CustomerViewController.swift
//  
//
//  Created by Panupong Chaiyarut on 18/9/2562 BE.
//

import UIKit
import Firebase
import FirebaseDatabase

class CustomerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
       let ref = Database.database().reference(withPath: "Bill-items")
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Customercell") as! CustomerTableViewCell
        
          let billItem = bills[indexPath.row]
        
        cell.cusNamelbl.text = "Bill "+billItem.key
        cell.cusStatuslbl.text = billItem.time
        cell.totallbl.text = String(billItem.totalPrice)
        
        return cell

    }
    
    @IBOutlet weak var OpenMenu: UIBarButtonItem!
    
    
    @IBOutlet weak var tableView: UITableView!
     var bills: [BillItem] = []
    
    
    func getbill(){
        ref.observe(.value, with: { snapshot in
            var newBills: [BillItem] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let billItem = BillItem(snapshot: snapshot) {
                    newBills.append(billItem)
                }
            }
            self.bills = newBills
            self.tableView.reloadData()
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getbill()
        
        OpenMenu.target = self.revealViewController()
        OpenMenu.action = Selector("revealToggle:")

        
    }
    
    var billkey: String?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let detailhistory = storyboard?.instantiateViewController(withIdentifier: "showhistorydetail") as! HistoryDetailViewController
        
//       billkey = bills[indexPath.row].key
//      billkey = detailhistory.getbill
            detailhistory.getbill = bills[indexPath.row].key
            detailhistory.getsum = bills[indexPath.row].totalPrice
     //  print("billkey ",billkey)
        
        self.navigationController?.pushViewController(detailhistory, animated: false)
        
        
        tableView.reloadRows(at: [indexPath], with: .none)
        tableView.deselectRow(at: [indexPath.row], animated: false)
        
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
