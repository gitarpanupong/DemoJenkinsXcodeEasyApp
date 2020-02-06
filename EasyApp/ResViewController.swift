//
//  ResViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 30/10/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ResViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
     // let ref = Database.database().reference(withPath: "Food-items")
    
    // let ref = Database.database().reference(withPath: "Restaurant")
    @IBOutlet weak var couterbutton: UIButton!
    @IBOutlet weak var kitchenbutton: UIButton!
    
    
        var ref: DatabaseReference!
   //  let ref = Database.database().reference()
    
    //let ref = Database.database().reference(withPath: "Restaurant")
    
    @IBOutlet weak var tableView: UITableView!
    
    var restaurants: [RestaurantItem] = []
    
    var resname : String = ""
     var resPhone : String = ""
     var resPlace : String = ""
     var resTime : String = ""
    
    
  //  var time
    
  
       
    
    func load(){
    /*
        ref.child("Restaurant").observe(.value, with: { snapshot in

              var newRes: [RestaurantItem] = []

                for child in snapshot.children {
                    
                   
                    //  let imageSnap = snap.childSnapshot(forPath: "Photo")
                    
                //        let nameSnap = snap.childSnapshot(forPath: "name")
                  //      let dict = nameSnap.value as! [String: Any]
                        
                     
                     //   let dict = imageSnap.value as! [String: Any]
                     //   let url = dict["image"] as! String
                    
                    print("Load ",name)
                    
                    
//                               if let snapshot = child as? DataSnapshot,
//                                let resItem = RestaurantItem(snapshot: snapshot) {
//
//                                newRes.append(RestaurantItem(snapshot: snapshot)!)
//                               }
                           }
                self.restaurants = newRes
                self.tableView.reloadData()
          })
        */
//        print("Load ")
//          ref.child("Restaurant").child("สบายกระเป๋า".observe(.value, with: { snapshot in
//                var dataArr: [RestaurantItem] = []
//                for child in snapshot.children {
//                           print("Yes ")
//                           if let snapshot = child as? DataSnapshot,
//                               let cateData = RestaurantItem(snapshot: snapshot) {
//                               print("cateData ",cateData)
//                               dataArr.append(cateData)
//                           }
//                       }
//
//                       self.restaurants = dataArr
//                    self.tableView.reloadData()
//          })
                       

        ref.child("Restaurant").observe(.value, with: { (snapshot) in
            
         //   print("จำนวนร้าน",snapshot.childrenCount)
            
            if snapshot.childrenCount > 0 {
                self.navigationItem.rightBarButtonItem = nil
                self.couterbutton.isHidden = false
                self.kitchenbutton.isHidden = false
            }
            
            if let value = snapshot.value as? [String: Any] {
                self.resname = value["name"] as? String ?? ""
                self.resPhone = value["phone"] as? String ?? ""
                self.resPlace = value["place"] as? String ?? ""
                self.resTime = value["time"] as? String ?? ""
                //print("resname ",self.resname)

            }
            self.tableView.reloadData()
        })
 
        
    }
    
   var count = 120
    @objc func update() {
      if(count > 0) {
         // countDownLabel.text = String(count--)
        count -= 1
     //   self.title = String(count)
      
        print("countDown ",count)
      }
  }
    //  var timer: Timer?
    
//    @objc func action () {
//    print("done")
//    }
//
    override func viewWillAppear(_ animated: Bool) {
         self.navigationItem.leftBarButtonItem = nil
    }
    
    
    var array = ["14:03:14","14:03:11","ก"]
    
    //var array = ["Table 4","Table 1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.couterbutton.isHidden = true
         self.kitchenbutton.isHidden = true
        
        
        var date = Date()
             let formatter = DateFormatter()
             formatter.dateFormat = "HH:mm:ss"
             let result = formatter.string(from: date)
        
        array.append(result)
        
        array.sort()
        
        print("array ",array)
           
             print("Time ",result)
        
       // self.navigationItem.leftBarButtonItem?.isEnabled = false
        
       //  self.navigationItem.leftBarButtonItem = nil
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
   
        
      //  self.couterbutton.isHidden = false
        //              self.kitchenbutton.isHidden = false
   //   CGFloat screenScale = [[UIScreen mainScreen] scale];
        
        let screenScale = UIScreen.main.scale
        
        ref = Database.database().reference()
       // ref =  Database.database().reference(withPath: "Restaurant")

    //  Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
    // timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: false)
        load()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resname != "" {
            return 1
        }else {
             return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Rescell", for: indexPath) as! ResTableViewCell
         var cell = tableView.dequeueReusableCell(withIdentifier: "Rescell") as! ResTableViewCell
            
       // cell.resImage = restaurants[indexPath.row].resimage
      //  let restaurantsItem = restaurants[indexPath.row]
        
      
        
        cell.resName.text = resname
        cell.resPhone.text = resPhone
        cell.resPlace.text = resPlace
        cell.resTime.text = resTime
        
        
        let imageRef = Storage.storage().reference().child("Info").child(resname.lowercased()+".jpg")
              imageRef.getData(maxSize: 100*1024*1024, completion: { (data, error) -> Void  in
                  
                  
                  if error == nil {
                      print("Data")
                      print(data)
                    cell.resImage?.image = UIImage(data: data!)
                      
                   //print(error?.localizedDescription)
                      
                  } else {
                     
                       print("error")
                    //  print(data)
                      print(error?.localizedDescription)
                    
                  }
                  
              })
          
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
          //      let revealViewController: SWRevealViewController = self.revealViewController()
           //      let cell: MenuCell = tableView.cellForRow(at: indexPath) as! MenuCell
            
        tableView.deselectRow(at: indexPath, animated: true)
        
//                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                     let main = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") //SWRevealViewController
//                     self.present(main, animated: true, completion: nil)
    
     
        
           let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! SWRevealViewController
        self.navigationController?.pushViewController(detailVC, animated: false)
        
        
       //      let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "tablefoodlist") as! TableViewController
        //    self.navigationController?.pushViewController(detailVC, animated: false)
    

//    let cell = tableView.dequeueReusableCell(withIdentifier: "Rescell", for: indexPath)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    }
    
    
    @IBAction func counterbtn(_ sender: Any) {
        
            let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "tablefoodlist") as! TableViewController
        
        detailVC.countertype = "เครื่องดื่ม"
            
                self.navigationController?.pushViewController(detailVC, animated: false)
        
        
    }
    
    @IBAction func kitchenbtn(_ sender: Any) {
        
        
        
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "tablefoodlist") as! TableViewController
        
         detailVC.countertype = "อาหาร"
        
                     self.navigationController?.pushViewController(detailVC, animated: false)
 
 
 
    }
    
 
    
}
