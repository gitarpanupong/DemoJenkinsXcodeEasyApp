//
//  TableViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 5/8/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
   
    var tables: [TableItem] = []
    var sortedArray: [AnyObject] = []
    
    var refTables: DatabaseReference!
    var status: String!
    
    let ref = Database.database().reference(withPath: "Table-items")
     let orderref = Database.database().reference(withPath: "Order-items")
     let orderlistref = Database.database().reference(withPath: "Orderlist-items")
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var OpenMenu: UIBarButtonItem!
    
    var countertype: String?
    
    var countTable : Int = 1
    
       var countorder: Int = 1
    
    
      var orderlists: [OrderlistItem] = []
    
       var orders: [OrderItem] = []
    var counts:[[Int]] = Array(repeating: Array(repeating: 0, count: 1), count: 5)
        var num: Int = 0
    
    
    
    //var countarray = [[AnyObject]]()
    
    var countarray = [[String:String]]()
      var countarraylist = [[String:String]]()
//     var check = [[String:String]]()
           var counttable: [String] = []
            var countnum: [Int] = []
      var checkrow: [String] = []
       var check: [String] = []
    
    
    
     
    
  /*
    
      func count() {
            
            print("count ")
             var num = 0
            self.orderlistref.queryOrdered(byChild: "orderid").observe(.value, with: { (snapshot: DataSnapshot!) in
                        self.countorder = Int(snapshot.childrenCount)
                         print("จำวนนนน ",self.countorder)
                
                         
                for i in self.orders {
                   
                                for j in self.orderlists {
                                    if j.orderid == i.orderid  {
                                       
                                           
                                        if self.countarray.count == 0 {
                                             num = num + 1
                                            self.countarray.append(["Num": String(num),"Table": i.tableid])
                                          //   print("countarray ",self.countarray)
                                        } else if i.tableid ==  self.countarray[self.countarray.count - 1]["Table"] {
                                              num = num + 1
                                             self.countarray[self.countarray.count - 1]["Num"] = String(num)
                                             //print("countarray2 ",self.countarray)
                                        } else {
                                            num = 0
                                            num = num + 1
                                              self.countarray.append(["Num": String(num),"Table": i.tableid])
                                          //   print("countarray3 ",self.countarray)
                                        }
                                         
                                            self.listid = j.orderitemid
                                            
                                           
                                            self.countarraylist.append(["Tableid": i.tableid,"Listid": self.listid!])
          
                                     
                                           // print(num,"num ",i.tableid," listid ",self.listid)
                                          //  self.tableView.reloadData()
                                        }
                                    }
                  
                    
                          
    //                if self.countarray.count == 0 {
    //                      self.countarray.append(["Num": String(num),"Table": i.tableid])
    //                }
    //                else {
    //                    if i.tableid ==  self.countarray[self.countarray.count - 1]["Table"] {
    //
    //                        print(" num ",num,"itable ",i.tableid," itablecount ",self.countarray[self.countarray.count - 1]["Table"])
    //                        self.countarray[self.countarray.count - 1]["Num"] = String(num)
    //
    //                     //   print("countarray ",self.countarray)
    //                      //  num = 0
    //                    }else {
    //
    //                        self.countarray.append(["Num": String(num),"Table": i.tableid])
    //
    //                    }
    //                }
                              
            }
                print("count array ",self.countarray)
            })
          
           
            
        }
    */
    
    func order(){
      
    self.orderref.queryOrdered(byChild: "tableid").observe(.value, with: { (snapshot: DataSnapshot!) in
          var newOrders: [OrderItem] = []
                                                        
        
    //    print("Order ")
                                       //  print("โต๊ะ ",table)
            for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                        let orderItem = OrderItem(snapshot: snapshot) {
                        
                        if orderItem.pay == "no" {
                            newOrders.append(orderItem)
                        }

                    }
             }
              self.orders = newOrders
     //   self.tableView.reloadData()

    })
       
             
    }
    
    
    var type: String?
    
    
    func orderlist(){

        self.orderlistref.queryOrdered(byChild: "orderid").observe(.value, with: { (snapshot: DataSnapshot!) in
//               self.countorder = Int(snapshot.childrenCount)
//                print("จำวนนนน ",self.countorder)
            print("OrderList ")
            var newOrderslist: [OrderlistItem] = []
                                                             
                 for child in snapshot.children {
                         if let snapshot = child as? DataSnapshot,
                             let orderlistItem = OrderlistItem(snapshot: snapshot) {
                            
          
                                        
                            if orderlistItem.type == self.countertype  {
                                 newOrderslist.append(orderlistItem)
                            }else if self.countertype == nil {
                                newOrderslist.append(orderlistItem)
                            }
                         }
                  }
          
                   self.orderlists = newOrderslist
            
            
 
            
            
            
            self.realcheckMatch()
        self.tableView.reloadData()
        })
            
    }
    
    var checkordertable: [[String]] = []
      var checkrowtable: [[String]] = []
    
    var countrow: [[String]] = []
    var checksection: [Int] = []
    
    func realcheckMatch() {
      //  print("read check")
//        for i in orders {
//            for j in tables {
//                if i.tableid == j.name {
//                    checkordertable.append([i.orderid,j.name])
//
//                }
//            }
//        }
        
        
//         for i in orders {
//            for j in self.orderlists {
//                    //if i.tableid == tables[section].name && j.orderid == i.orderid {
//                if i.orderid == j.orderid {
//
//                    checkrowtable.append([i.tableid,j.orderitemid])
//                    print("ได้เฉย ",checkrowtable)
//                }
//            }
//        }
        
        var num: Int = 0
        var section: Int = 0
       // var countrow: [[String]] = []
        checkrowtable.removeAll()
        countrow.removeAll()
        
        for i in orders {
           for j in self.orderlists {
                          //if i.tableid == tables[section].name && j.orderid == i.orderid {
            if i.orderid == j.orderid  && j.status != 4 {//&& j.status != 2{

                    
                if countrow.count == 0 {
                    num = num + 1
                  //  section += 1
                  
                   checkrowtable.append([i.tableid,String(section),j.orderitemid])
                    countrow.append([i.tableid,String(num)])
                }

                else if countrow[countrow.count - 1][0] == i.tableid {
                    num = num + 1
                     section = section + 1
                    checkrowtable.append([i.tableid,String(section),j.orderitemid])
                    countrow[countrow.count - 1][1] = String(num)
                  
                }
                else {
                    num = 0
                    num = num + 1
                    section = 0
                      
                    
                    checkrowtable.append([i.tableid,String(section),j.orderitemid])
                    countrow.append([i.tableid,String(num)])
                }
                  
             }
         
           }
      }
               // print("count row",countrow[1])
          //    print("ได้เฉย ",checkrowtable)
        
        tableView.reloadData()
       // (index, value)
        
   /*     for i in checkrowtable{
            for (index, value) in tables.enumerated() {
                if i[0] == value.name {
               
                    if count.count == 0 || count[0].contains(value.name) {
                        num += 1
                    //    count.append(["", value.name])
                        count.append(["Num": String(num)]) //orderitemid
                          print("count ",count[0])
                      
                    }else {
                        num = 0
                        num += 1
                        // count.append([value.name,String(num)])
                    }
//                    if count.count == 0 { //|| count[count.count][0] == count[count.count - 1][0]{
//                         num = num + 1
//                        count.append([j.name,String(num)])
//
//                    } else {
//                        num = 0
//                        num = num + 1
//                        count.append([j.name,String(num)])
//
//
//                    }
                   // print("count ",count[])
                 
                         print(value.name," โต๊ะ ",num)
                }
            }
           
           
        }
         */
        
    }
        
    
    
     var listid: String?
      var press: [String] = []
     var press2: [String] = []
    var letters = [[String]]()
    var checkcounter : String?
        
          func table() {
            
     
            
            ref.queryOrdered(byChild: "name").queryLimited(toFirst: 100).observe(.value, with: { snapshot in
                    var newTables: [TableItem] = []
                    for child in snapshot.children {
                        if let snapshot = child as? DataSnapshot,
                            let tableItem = TableItem(snapshot: snapshot) {
                            
                            
                            
                            if self.countertype == nil{
                                newTables.append(tableItem)
                            }else{
                                if (self.countertype == "อาหาร" && tableItem.statusfood != "free" ){// && tableItem.statusfood != "ก" ){
                                       newTables.append(tableItem)
                                   
                                }
                                else if (self.countertype == "เครื่องดื่ม" && tableItem.statuswater != "free" ){//&& tableItem.statuswater != "ก") {
                                       newTables.append(tableItem)
                                  
                                }
                            
                            }
                      //    self.order(table: tableItem.name)
                       
                        }
                    }
                
                   self.tables = newTables
                  let yourTableViewPeriodsArray = self.tables.reversed()
                  
                 // print("เรียงโต๊ะ1  ",yourTableViewPeriodsArray)
                //  print("num",self.tables.count)
               
                //  self.tableView.reloadData()
            //     self.realcheckMatch()
                
                
                //print("sort ",tables.sorted())
                
                if self.countertype == "อาหาร" {
                    self.tables.sort { $0.statusfood < $1.statusfood}
                }else if self.countertype == "เครื่องดื่ม" {
                     self.tables.sort { $0.statuswater < $1.statuswater}
                }else {
                    self.tables.sort { $0.time < $1.time}
                }
             //   print("Tablesort ",self.tables)
                     
                 self.tableView.reloadData()
              })
                     
          }
    
    
    
    
    func check(row: Int,section: Int){
        
     //   print("check ")
       var num: Int = 0

         if row == 0 {
            // check.removeAll()
           for i in orders {
             for j in self.orderlists {
                if i.tableid == tables[section].name && j.orderid == i.orderid  {
                        
                 //   print(num,"num ","index row ",row," - ",j.orderitemid)
                   
                     checkrow.append(String(num))
                   
                     check.append(j.orderitemid) // เช็ค จำนวนโต๊ะ
                  //   print("check ",check)
                 //   print("check ",check)
                  //  print("check ",check)
                  //   print("0 ",checkrow[num])
                     self.press2.append(i.tableid)
                    
//                    print("check row ",checkrow)
//                     print("check ",check)
                 
                      num = num + 1
                    
                     //  cell.foodstatuslbl.text = j.orderitemid

                 }

             }
            
           // print("press 2 ",press2)
//            if i.tableid == self.press2[self.press2.count - 1] {
//
//            }else{
//                    num = 0
//            }

         }
           //  tableView.reloadData() /// ตรงนี้ <<<<<<<<<<<<<<<<<<<<<<<<
         }
      //  tableView.reloadData()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.rowHeight = UITableView.automaticDimension
      
        //  tableView.reloadData()
     //   DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    func backAction(){
        
          let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "gotoreshome") as! ResViewController
        self.navigationController?.pushViewController(detailVC, animated: false)
    }
    
    
    @IBOutlet weak var addbtn: UIBarButtonItem!
    @IBOutlet weak var deletebtn: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 243
        tableView.rowHeight = UITableView.automaticDimension
        

        if countertype == nil {
            OpenMenu.target = self.revealViewController()
            OpenMenu.action = Selector("revealToggle:")
        }
        else {
            addbtn.isEnabled = false
              deletebtn.isEnabled = false
            title = "รายการ"+(String(countertype!))
            addbtn.title = ""
            deletebtn.title = ""
        }
        
        
        
        
        
   //     self.title = "รายการเครื่องดื่ม"
    
       
     self.order()
          
           self.orderlist()
          
           // self.count()
           self.table()
        
  
              

    }
    
    var A : Int = 0
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
       // print("Whay ")

        for (index , value) in countrow.enumerated() {
            
            if tables[section].name == value[0] {
            
              //  print(tables[section].name," value ",value[1])
                 A = Int(value[1]) as! Int
                 return  A
            }

//            if tables[section].name == value[index][0] {
//
//                A = Int(i[1]) as! Int
//
//                return  A
//
//            }else {
//                return 0
//            }

        }
//
//        if countrow[0].contains(tables[section].name) {
//            return countrow[1] as! Int
//        }else {
//            return 0
//        }
//
       
        
//        for i in countarray {
//           // print("Table ",i["Table"])
//            if tables[section].name == i["Table"] {
//                 // print(tables[section].name," -Match- ",i["Table"]," and ",i["Num"])
//               // counts[section][0] = i["Num"] as! Int
//                A = Int(i["Num"]!) as! Int
//                print("แถว ",A)
//                return A
//            }
//
//        }

         //   print("A = ",A)
           if tables[section].status == "busy" {
        //print(section," eiei ",counts[section][0])
            //    print("Fuck ",counts[section][0])
               return counts[section][0]
            }else{
               return 0
           }
 
       }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let tableItem = tables[indexPath.row]
            
                if tableItem.status == "busy"{
                    let alert = UIAlertController(title: "เตือน!", message: "ไม่สามารถลบได้เนื่องจากโต๊ะมีการใช้งาน", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                   
                }else if tableItem.status == "free" {
                    print("ว่าง ลบได้")
                    tableItem.ref?.removeValue()
            }
        }
    }
    
      var countordertable: Int = 1
    
    
    
    var B: Int = 0
    var tab: Int = 0
    var counttablerow : [String] = [] // นับซ้ำ
    
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableStatusTableViewCell
        
    //    cell.layer.cornerRadius = 15
     //   cell.layer.borderWidth = 1
        
    
       //  let fuck = checkrowtable[indexPath.row]
      
      
        
        let orderlistItem = orderlists[indexPath.row]
        let tableItem = tables[indexPath.section]
        
       //   print("What",tableItem)
        // table == indexpath.row
        
       // print("table ",tables[indexPath.row].name," section",indexPath.section)
       // print("How ",checkrowtable[indexPath.row])
     //   print("indexpath.row ",indexPath.row," indexpath.section",indexPath.section," Table ",checkrowtable[indexPath.section])
        
      //  print(" section ",indexPath.section," table ",tableItem.name," check ",checkrowtable[indexPath.row])
        
       //  counttablerow.append(tables[indexPath.section].name)
        
    
        for check in checkrowtable {
          
            if tables[indexPath.section].name == check[0]  && String(indexPath.row) == check[1] {
         //        print(check[0]," check ",check[1])
                //print(indexPath.row," row ",tables[indexPath.section].name," section ",check[2])
             
                // counttablerow.append
               // cell.foodnamestatuslbl.text = check[2]
                
                for i in orderlists {
                    if i.orderitemid == check[2] {
                     //   print("check ",check[2])
                        cell.foodnamestatuslbl.text = i.foodname
                        cell.foodtypelbl.text = i.type
                        cell.foodquantitylbl.text = String(i.quantity)
                        cell.foodstatuslbl.text = "รายการใหม่"
                                       
                        
                        if i.status == 0 {
                              cell.contentView.backgroundColor = #colorLiteral(red: 0.9510123134, green: 0.3623146415, blue: 0.3538915515, alpha: 1)
                                   cell.foodtypelbl.text = "รายการใหม่"
                            }
                            else if i.status == 1 {
                                cell.contentView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                                cell.foodtypelbl.text = "รายการใหม่"
                                }
                               else if i.status == 2 {
                                 cell.contentView.backgroundColor = #colorLiteral(red: 0.9396336079, green: 0.8933145404, blue: 0.1257261634, alpha: 1)
                                 cell.foodtypelbl.text = "รับออร์เดอร์แล้ว"
                                }
                                  else if i.status == 3 {
                                      cell.contentView.backgroundColor = #colorLiteral(red: 0.4985563755, green: 0.9418702126, blue: 0.1118808761, alpha: 1)
                                     cell.foodtypelbl.text = "เสร็จแล้ว"
                                }

                    }
                }
                
            }
        }
        
        
        
//        if indexPath.row == 0 {
//            check(row: 0,section: indexPath.section)
//        }
        
      // print("Ahh ",checkrow[indexPath.row])
            /*
     
        print(checkrow[indexPath.row]," row ",indexPath.row)
        print("count ",checkrow.count)
        
        if String(indexPath.row) == checkrow[indexPath.row] {
            
            for i in orderlists {
                if i.orderitemid == check[indexPath.row] {
                    cell.foodnamestatuslbl.text = i.foodname
                    cell.foodtypelbl.text = i.type
                    cell.foodquantitylbl.text = String(i.quantity)

                    cell.foodstatuslbl.text = "รายการใหม่"
                    if i.status == 0 {
                       cell.contentView.backgroundColor = #colorLiteral(red: 0.9510123134, green: 0.3623146415, blue: 0.3538915515, alpha: 1)
                    }
                    else if i.status == 1 {
                         cell.contentView.backgroundColor = #colorLiteral(red: 0.9396336079, green: 0.8933145404, blue: 0.1257261634, alpha: 1)
                    }
                    else if i.status == 2{
                         cell.contentView.backgroundColor = #colorLiteral(red: 0.4985563755, green: 0.9418702126, blue: 0.1118808761, alpha: 1)
                    }
                }
            }

        }
         */
        

        return cell
        
    }
    
    @IBAction func onAddTapped(_ sender: Any) {

        var text = "Table "+String(tables.count + 1)
        
        
          let key = self.ref.child("Table "+String(tables.count + 1)).childByAutoId().key
            
            let tableItem = TableItem( name: text,
                                       key: key!,
                                       status: "free",
                                       statusfood: "free",
                                       statuswater: "free",
                                       time: "0")
        
            let tableItemRef = self.ref.child("Table "+String(tables.count + 1))
            tableItemRef.setValue(tableItem.toAnyObject())
            
        }
    
    @IBAction func onDeleteTapped(_ sender: Any) {
          let tableItem = self.tables[tables.count - 1]
        
        if tables.count > 0 {
          
            if tableItem.status == "busy" || tableItem.status == "call" {
                let alert = UIAlertController(title: "เตือน!", message: "ไม่สามารถลบได้เนื่องจากโต๊ะมีการใช้งาน", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }else if tableItem.status == "free" {
                
                
               if let i = tables.index(where: {$0.name == "Table "+String(tables.count)}) {
                print("table ",tables[1])
               print(" ว่าง ลบได้ ",i+1)
                 
                  tables[i].ref?.removeValue()
                }
            
            }

        }
        
    }
    var SelectedIndext = -1
    var isCollapce = false
    
 var selectedIndexPath: IndexPath? = nil
    var keeporderlistid: String = ""
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
//            if selectedIndexPath == indexPath {
//                 // it was already selected
//
//                 selectedIndexPath = nil
//                 tableView.deselectRow(at: indexPath, animated: false)
//                print("deselect")
//             } else {
//        print("select")
//                      selectedIndexPath = indexPath
//                          }
                 // wasn't yet selected, so let's remember it
              
        
    //    let showorderFood = storyboard?.instantiateViewController(withIdentifier: "showStatusOrder") as! TableOrderViewController
        
     
       
    
 
        
        
//        if SelectedIndext == indexPath.row
//        {
//            if self.isCollapce == false
//            {
//                self.isCollapce = true
//            }else
//            {
//                self.isCollapce = false
//            }
//        }else{
//            self.isCollapce = true
//        }
//        self.SelectedIndext = indexPath.row
//
        
        
//        if selectedIndexPath == indexPath {
//                  // it was already selected
//
//                  selectedIndexPath = nil
//                  tableView.deselectRow(at: indexPath, animated: false)
//                 print("deselect")
//              } else {
//                  // wasn't yet selected, so let's remember it
                  let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableStatusTableViewCell
//                 print("select")
//                  selectedIndexPath = indexPath
//
//
//             }
        
    //    cell.foodtypelbl.textAlignment = .right
       //    cell.foodtypelbl.layoutIfNeeded()
    
                          // it was already selected

    
           
    //    print("row ",indexPath.row,"Section ",tables[indexPath.section])
//        print("checkrow ",check[indexPath.row] ,"Section ",check[indexPath.section])
       
      //  check(row: 0,section: indexPath.section)
        
        
      //  print("check ",checkrowtable[indexPath.section])
        
      
            
            //  if String(indexPath.row) == checkrow[indexPath.row] {
        
      //  print("จำนวน ",counts[indexPath.section][0])

              
//
      
        
        
        for j in checkrowtable {
           // print("j ",j)
            if tables[indexPath.section].name == j[0] && String(indexPath.row) == j[1] {
               // print("i",j[2])
           
            
                
        
            for i in orderlists {
                        // if i.orderitemid == check[indexPath.row]  {
                
                if i.status == 2 {
                    print("orderlist ",i.orderitemid)
                }
                
                               if i.orderitemid == j[2]  {
                    
                                
                              
                                
                         //  tableView.reloadRows(at: [indexPath], with: .automatic)
                                if i.status == 0  {
                                cell.contentView.backgroundColor = #colorLiteral(red: 0.9396336079, green: 0.8933145404, blue: 0.1257261634, alpha: 1)
                               self.orderlistref.child(i.orderitemid).updateChildValues(["status": 2])
                               tableView.reloadRows(at: [indexPath], with: .none)
                            }
                            else if i.status == 1  {
                                    cell.contentView.backgroundColor = #colorLiteral(red: 0.9396336079, green: 0.8933145404, blue: 0.1257261634, alpha: 1)
                                    self.orderlistref.child(i.orderitemid).updateChildValues(["status": 2])
                                tableView.reloadRows(at: [indexPath], with: .none)
                                                              }
                                else if i.status == 2 {
                                 tableView.reloadRows(at: [indexPath], with: .none)
                                   cell.contentView.backgroundColor = #colorLiteral(red: 0.4985563755, green: 0.9418702126, blue: 0.1118808761, alpha: 1)
                                
                               self.orderlistref.child(i.orderitemid).updateChildValues(["status": 3])
                            
                                }
                                    else if i.status == 3 {
                                    tableView.reloadRows(at: [indexPath], with: .none)
                                 cell.contentView.backgroundColor = #colorLiteral(red: 0.4985563755, green: 0.9418702126, blue: 0.1118808761, alpha: 1)
                                    
                             if countertype == "อาหาร" {
                            ref.child(tables[indexPath.section].name).updateChildValues(["statusfood": "ก"])
                                } else if countertype == "เครื่องดื่ม" {
                            ref.child(tables[indexPath.section].name).updateChildValues(["statuswater": "ก"])
                                }
            
                                 }
                                    
                                else {
                               tableView.reloadRows(at: [indexPath], with: .none)
                           }
                           }
                    }
            }
            
            
       
            
        }
        
     
        
        
        
            
          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     /*
          //  print("why ",tables[indexPath.section].name)
        for i in orders {
                          if i.tableid == tables[indexPath.section].name {
                              print(" eiie ")
                              for j in orderlists {
                                  if j.orderid == i.orderid && j.status == 3 {
                                      countnumm += 1
                                      print(countnumm," why ",j.orderitemid)

                                  }
                              }

                          }
                      }
              //    countnumm = 0
    
  
        if countnumm == 1 {
            print(tables[indexPath.section].name," ได้ครบแล้ว ")
         
       //    ref.child(tables[indexPath.section].name).updateChildValues(["status": "busy"])
            if countertype == "อาหาร" {
                ref.child(tables[indexPath.section].name).updateChildValues(["statusfood": "ก"])
            } else if countertype == "เครื่องดื่ม" {
                ref.child(tables[indexPath.section].name).updateChildValues(["statuswater": "ก"])
            }
        }
        
        countnumm = 0
        
        
        */
        
        
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
                    
//                  for i in orderlists {
//                     // if i.orderitemid == check[indexPath.row]  {
//                            if i.orderitemid == keeporderlistid  {
//                      //  tableView.reloadRows(at: [indexPath], with: .automatic)
//                         if i.status == 0 {
//                             cell.contentView.backgroundColor = #colorLiteral(red: 0.9396336079, green: 0.8933145404, blue: 0.1257261634, alpha: 1)
//                            self.orderlistref.child(i.orderitemid).updateChildValues(["status": 1])
//
//                            tableView.reloadRows(at: [indexPath], with: .none)
//                         } else if i.status == 1 {
//                              tableView.reloadRows(at: [indexPath], with: .none)
//                                cell.contentView.backgroundColor = #colorLiteral(red: 0.4985563755, green: 0.9418702126, blue: 0.1118808761, alpha: 1)
//
//                            self.orderlistref.child(i.orderitemid).updateChildValues(["status": 2])
//
//                         } else {
//                            tableView.reloadRows(at: [indexPath], with: .none)
//                        }
//                        }
//                    }
                      //  tableView.reloadSections([indexPath.section], with: .none)

//                        if i.status == 0 {
//                            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableStatusTableViewCell
//
//                            cell.layer.cornerRadius = 15
//                            cell.layer.borderWidth = 2
//                            cell.foodnamestatuslbl.text = i.foodname
//                            cell.foodtypelbl.text = i.type
//                            cell.foodquantitylbl.text = String(i.quantity)
//                            cell.foodstatuslbl.text = "ได้รับรายการ"
//                            cell.contentView.backgroundColor = #colorLiteral(red: 0.9396336079, green: 0.8933145404, blue: 0.1257261634, alpha: 1)
//
//                            self.orderlistref.child(i.orderitemid).updateChildValues(["status": 1])
//
//
//
//
//                        } else if i.status == 1 {
//                            cell.contentView.backgroundColor = #colorLiteral(red: 0.4985563755, green: 0.9418702126, blue: 0.1118808761, alpha: 1)
//                           self.orderlistref.child(i.orderitemid).updateChildValues(["status": 2])
//                        }
                           
                        //}
                  //  }
                
        
                
              
              
        
        //     self.orderlistref.child(i.orderitemid).updateChildValues(["status": 1])
                         
                 //        tableView.reloadRows(at: [indexPath], with: .none)
//
        
     //   cell.accessoryType = .checkmark
        
    //   tableView.deselectRow(at: indexPath, animated: true)
    
        
        
      //  tableView.reloadSections([indexPath.section], with: .none)
        
        
    }
    
    
   var countnumm : Int = 0
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.SelectedIndext == indexPath.row && isCollapce == true
        {
            print("yes ")
            return 0
        }else
        {
            // return 50
            return 40
        }
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return tables.count
   
    }
    
 // let screenSize = UIScreen.main.bounds
    let screenWidth = UIScreen.main.bounds.width
        
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
      //  headerView.layer.cornerRadius = 15
       //  headerView.layer.borderWidth = 1
       // headerView.layer.borderColor = UIColor(red: 29/255, green: 30/255, blue: 32/255, alpha: 1).cgColor
        headerView.layer.borderColor  = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
        headerView.backgroundColor = UIColor(red: 29/255, green: 30/255, blue: 32/255, alpha: 1)

        let label = UILabel()
        //15
        label.frame = CGRect.init(x: 15, y: 0, width: headerView.frame.width-10, height: headerView.frame.height-10)
        let tableItem = tables[section]
        label.font = UIFont.boldSystemFont(ofSize: 19.0)
        label.text = tableItem.name
           label.textColor = UIColor.white
        let label2 = UILabel()
        //250
        label2.frame = CGRect.init(x: screenWidth-170, y: 0, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label2.font = UIFont.boldSystemFont(ofSize: 19.0)
         label2.textColor = UIColor.white
        label2.text = "สถานะ : "
        
      
        //335
        let label3 = UILabel()
           //   label3.frame = CGRect.init(x: screenWidth-105, y: 0, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label3.font = UIFont.boldSystemFont(ofSize: 19.0)
   //     label3.textAlignment = .right
            tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .none)
        
            if tableItem.status == "free" {
                  status = "ว่าง"
                   label3.text = status
                      label3.frame = CGRect.init(x: screenWidth-60, y: 0, width: headerView.frame.width-10, height: headerView.frame.height-10)
                   label3.textColor = UIColor.green
              }
              else if tableItem.status == "busy" {
                 label3.frame = CGRect.init(x: screenWidth-60, y: 0, width: headerView.frame.width-10, height: headerView.frame.height-10)
                  status = "ไม่ว่าง"
                   label3.text = status
                    label3.textColor = UIColor.red
                
              }
              else if tableItem.status == "call" {
                    label3.frame = CGRect.init(x: screenWidth-120, y: 0, width: headerView.frame.width-10, height: headerView.frame.height-10)
                  status = "เรียกชำระเงิน"
                  label3.text = status
                  label3.textColor = UIColor.yellow
              }
        
       // print("งิงิ")
       // tableView.reloadData()
        
       
     //   label3.sizeToFit()
       // label3.adjustsFontSizeToFitWidth = true
      //  label3.preferredMaxLayoutWidth = frame.width
        //headerView.backgroundColor = UIColor( red: CGFloat(255/255.0), green: CGFloat(111/255.0), blue: CGFloat(107/255.0), alpha: CGFloat(1.0) )
        headerView.addSubview(label)
       //  headerView.addSubview(label2)
         headerView.addSubview(label3)

        return headerView
    }
    
    
    @IBAction func Menubtn(_ sender: Any) {
        
   //     OpenMenu.target = self.revealViewController()
  //      OpenMenu.action = Selector("revealToggle:")
        
        if countertype != nil {
            backAction()
        }
    }
    
    
    

}
