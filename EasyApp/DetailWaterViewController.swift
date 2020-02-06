//
//  DetailWaterViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 7/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
///Users/gitar/Documents/EasyApp/NewWaterViewController.swift

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class DetailWaterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var price1: UITextField!
    @IBOutlet weak var price2: UITextField!
    @IBOutlet weak var price3: UITextField!
    
    var name : String!
     var waterid : String!
    var img : String!
    var price : String!
    var typename : String!
    var category : String!
     var waters: [WaterItem] = []
     var extras: [ExtraItem] = []
    
         let ref = Database.database().reference(withPath: "Food-items")
    
//    @IBOutlet weak var txtName: UITextField!
//    @IBOutlet weak var txtPrice: UITextField!
//    @IBOutlet weak var showImg: UIImageView!

    @IBOutlet weak var txtName: UITextField!
   // @IBOutlet weak var showImg: UIImageView!
 //   @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtPrice: UITextField!
    
    @IBOutlet weak var showImg: UIImageView!
    
    var checkextra: Int = 0
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtName.text = name
        txtPrice.text = price
        //let imgData = try? Data(contentsOf: img as! URL)
        //showImg.image = UIImage(data: imgData!)
        self.hotbutton.isHidden = true
        self.coldbutton.isHidden = true
        self.frappebutton.isHidden = true
           self.price1.isHidden = true
           self.price2.isHidden = true
           self.price3.isHidden = true
        self.hotbutton.setTitle("เพิ่ม", for: .normal)
        self.coldbutton.setTitle("เพิ่ม", for: .normal)
        self.frappebutton.setTitle("เพิ่ม", for: .normal)
        
        
        
        hotbutton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
          coldbutton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        frappebutton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        hotbutton.layer.borderWidth = 2
         coldbutton.layer.borderWidth = 2
         frappebutton.layer.borderWidth = 2
        
        hotbutton.layer.cornerRadius = 15
         coldbutton.layer.cornerRadius = 15
         frappebutton.layer.cornerRadius = 15
        
        self.ref.child("เครื่องดื่ม").child(waterid).observe(.value, with: { snapshot in
                                var newExtras: [ExtraItem] = []
                                    
                                                    for child in snapshot.children {
                                                     //     print("child ",child)
                                                        if let snapshot = child as? DataSnapshot,
                                                            let extraItem = ExtraItem(snapshot: snapshot) {
                                                            
                                                            newExtras.append(extraItem)
                                                            self.extrabutton.append([extraItem.name,extraItem.price])

                                                            if self.checkextra == 0 {
                                                                if extraItem.status == "on" {
                                                                  self.hotbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
                                                                }else {
                                                                       self.hotbutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                                                                }
                                                                self.hotbutton.setTitle(extraItem.name, for: .normal)
                                                                self.hotbutton.isHidden = false
                                                                   
                                                                 
                                                                self.price1.text = extraItem.price
                                                                 self.price1.isHidden = false
                                                                self.checkextra += 1
                                                            }else if self.checkextra == 1 {
                                                                if extraItem.status == "on" {
                                                                    self.coldbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
                                                                  }else {
                                                                                                                            self.coldbutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                                                                                                                               }
                                                                 self.coldbutton.setTitle(extraItem.name, for: .normal)
                                                                   self.coldbutton.isHidden = false
                                                                self.price2.text = extraItem.price
                                                                 self.price2.isHidden = false
                                                                self.checkextra += 1
                                                            }else {
                                                                 if extraItem.status == "on" {
                                                                                                                                 self.coldbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
                                                                                                                               }else {
                                                                                                                                      self.coldbutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                                                                                                                               }
                                                                self.frappebutton.setTitle(extraItem.name, for: .normal)
                                                                   self.frappebutton.isHidden = false
                                                                   self.price3.isHidden = false
                                                                self.price3.text = extraItem.price
                                                                self.checkextra = 0
                                                            }
                                                            
                                                            
                                                            /*
                                                            if extraItem.name == "ร้อน"  {
                                                                self.hotbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
                                                                
                                                            }
                                                            else if extraItem.name == "เย็น" {
                                                                self.coldbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
                                                            }
                                                            else if extraItem.name == "ปั่น" {
                                                                self.frappebutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
                                                            }
                                                            */
                                                            
                                                            
                                                            
                                                            
                                                            // print("extra name ",extraItem.name)
                                                        }
                   }
          self.extras = newExtras

            })

        
//        for i in extras {
//            if i.name == "ร้อน"  {
//                 hotbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
//            }
//            else if i.name == "เย็น" {
//                  coldbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
//            }
//            else {
//                 frappebutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
//            }
//
//
//
//        }
//
        
        
        
        let tapGestureToImageView = UITapGestureRecognizer(target: self, action: #selector(tapToImageView(sender:)))
        tapGestureToImageView.numberOfTapsRequired = 1
        showImg?.isUserInteractionEnabled = true
        showImg?.addGestureRecognizer(tapGestureToImageView)
        
        let imageRef = Storage.storage().reference().child("Water").child(self.txtName.text!.lowercased()+".jpg")
        imageRef.getData(maxSize: 100*1024*1024, completion: { (data, error) -> Void  in
            
            if error == nil {
                print("Data")
                print(data)
                self.showImg?.image = UIImage(data: data!)
                
                
            } else {
                
                print("error")
                //  print(data)
                print(error?.localizedDescription)
                
            }
            
        })
        
    }
     var match: Int!
    var getwaterid: String?
     var checkeiei: Int = 0
    @IBAction func btnSave(_ sender: Any) {
        
       // navigationController?.popViewController(animated: true)
        
        let storageRef = Storage.storage().reference().child("Water").child(txtName.text!.lowercased()+".jpg")
        
        let size = CGSize(width: 0, height: 0)
        
            switch Int((txtName?.text!)!) {
                                case nil:
                                      for i in self.waters {
                                                  if i.name == txtName?.text {
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
            
        
        if( txtName.text!.isEmpty || txtPrice.text!.isEmpty || showImg.image?.size.width == size.width){
            let alertController = UIAlertController(title: "Alert", message: "Please set foodName, foodPrice, choose image", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) {(action) in }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            
            
            if let uploadData = showImg.image!.pngData() {
                
                storageRef.putData(uploadData, metadata: nil, completion: {
                    (metadata, error) in
                    
                    if error != nil {
                        print(error)
                    }
                    
                    
                    storageRef.downloadURL(completion: { (url, error) in
                        if (error == nil) {
                            if let downloadUrl = url {
                                // Make you download string
                                let downloadString = downloadUrl.absoluteString
                                
//                                let waterItem = WaterItem(name: self.txtName.text,
//                                                        price: self.txtPrice.text!,
//                                                        category: self.category,
//                                                        foodimage: url!.absoluteString)
                                
                                self.ref.child("เครื่องดื่ม").queryOrdered(byChild: "name").queryEqual(toValue: self.txtName.text!).observeSingleEvent(of: .value, with: { snapshot in
                                    
                                    for child in snapshot.children {
                                        let DataSnap = child as! DataSnapshot
                                        let getid = DataSnap.key
                                      
                                        self.getwaterid = getid
                                        
                            self.ref.child("เครื่องดื่ม").child(getid).updateChildValues(["name": self.txtName.text,
                                                                "price": self.txtPrice.text!,
                                                                  "category": self.category,
                                                                  "foodimage": url!.absoluteString,
                                                                 "waterimagepath": self.txtName.text!+".jpg"])
                                        
                                        
                                     
                                        
                                            for i in self.extrabutton {
                                                    /*
                                               let extraItem = ExtraItem(name: String(i[0]),
                                                                         price: String(i[1]),
                                                                             status: "on")
                                                               
                                                    
                                               let waterItemRef = self.ref.child("เครื่องดื่ม").child(getid).child(i[0])
                                               waterItemRef.setValue(extraItem.toAnyObject())
                                                        */
                                                self.checkeiei += 1
                                                
                                                if self.checkeiei == 1 {
                                                    self.ref.child("เครื่องดื่ม").child(getid).child(i[0]).updateChildValues(["price": self.price1.text])
                                                }else if self.checkeiei == 2{
                                                      self.ref.child("เครื่องดื่ม").child(getid).child(i[0]).updateChildValues(["price": self.price2.text])
                                                }else if self.checkeiei == 3{
                                                     self.ref.child("เครื่องดื่ม").child(getid).child(i[0]).updateChildValues(["price": self.price3.text])
                                                }
                                           }

                                        
                                        
                                      //  print("getid ",getid)
                                /*
                                        for i in self.extras {
                                               //print("why eiei 1")
                                            for j in self.extrabutton {
                                                
                                               // print("why eiei 2",j)
                                                
                                                if i.name == j[0] {
                                                    self.checkeiei = 1
                                                    self.ref.child("เครื่องดื่ม").child(getid).child(j[0]).removeValue()
                                                  
                                                    break
                                                }else {
                                                  //  print("na ")
                                                    self.checkeiei = 2
                                                      let extraItem = ExtraItem(name: String(j[0]),
                                                                                 price: String(j[1]))
                                                      
                                                   
                                              let waterItemRef = self.ref.child("เครื่องดื่ม").child(getid).child(j[0])
                                                waterItemRef.setValue(extraItem.toAnyObject())
                                                    break
                                                }
                                            }
                                            
                                        }
                                        */
                                        
                                        
                                        
                               
                                        
                                    }
                                    
                                })
                                
                                print(downloadString)
                            }
                        } else {
                            print("Error What the fuck")
                        }
                    })
                    
                    
                    print("ข้าม")
                    
                    print(metadata)
                })
            }
            
          //  print(self.getwaterid," getid ",self.extrabutton)
            
            navigationController?.popViewController(animated: true)
            let waterViewController = self.navigationController?.topViewController as? WaterViewController
            waterViewController?.tableView?.reloadData()
            print("Save")
        }
          // print(self.getwaterid," getid ",self.extrabutton)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backshowWater" {
            // Get SecondVC
            let showWater = segue.destination as! WaterViewController
            
            // Pass text to SecondVC
            showWater.categoryName = category
            print(typename)
        }
    }
    
    
   @objc func tapToImageView(sender: UITapGestureRecognizer){
 print("Tap to imageView")
 let pickerController = UIImagePickerController()
 pickerController.delegate = self
 pickerController.allowsEditing = true
 pickerController.sourceType = .photoLibrary;
 self.present(pickerController, animated: true, completion: nil)
 }
 
 var newWater = Water()
 
 @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
 let chosenImage:UIImage = info[UIImagePickerController.InfoKey.originalImage]! as! UIImage
 showImg!.image = chosenImage
 newWater.image = chosenImage
 picker.dismiss(animated: true, completion: nil)
 print("eiei")
 }
    
    @IBOutlet weak var hotbutton: UIButton!
   // @IBOutlet weak var coldbtn: UIButton!
    @IBOutlet weak var frappebutton: UIButton!
    @IBOutlet weak var coldbutton: UIButton!
    
       var extrabutton = [[String]]()
    var check: Int = 0
    var checkonoff: Int = 0
    
    @IBAction func hotbtn(_ sender: Any) {
        
        print("ปุ่ม ",hotbutton.titleLabel!.text!)
        
          if hotbutton.titleLabel!.text! != "เพิ่ม" {
                if let index = extrabutton.index(where: { $0 == [hotbutton.titleLabel!.text!,price1.text]}) {
                         extrabutton.remove(at: index)
                     hotbutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                    
                }else {
                    for i in extras {
                        if i.name == hotbutton.titleLabel!.text! && i.status == "on"{
                            checkonoff = 1
                            break
                            
                        } else {
                            checkonoff = 2
                
                        }
                        
                        
                    }
                    
                    
                    
                    if checkonoff == 1 {
                        self.ref.child("เครื่องดื่ม").child(waterid).child(hotbutton.titleLabel!.text!).updateChildValues(["status": "off"])
                        hotbutton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                    }
                    else {
                        self.ref.child("เครื่องดื่ม").child(waterid).child(hotbutton.titleLabel!.text!).updateChildValues(["status": "on"])
                        hotbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
                    }
                    
                            
                }
                  
          } else {
               let alert = UIAlertController(title: "Edit Category", message: nil, preferredStyle: .alert)
            alert.addTextField { (textField) in
                                textField.text = ""
                              
                            }
            alert.addTextField { (textField2) in
                textField2.text = ""
              
            }
             let alert3 = UIAlertController(title: "เพิ่มข้อมูลเรียบร้อย", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                                 let textField = alert?.textFields![0]
                                let textField2 = alert?.textFields![1]
             
                
                self.extrabutton.append([textField!.text!,textField2!.text!])
                print(self.extrabutton)
                self.hotbutton.setTitle(textField?.text,for: .normal)
             //   self.itemName1.isHidden = false
                self.price1.isHidden = false
               // self.itemName1.text = textField?.text
                self.price1.text = textField2?.text
                
                self.hotbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
            
            }))
            let cancelAction = UIAlertAction(title: "Cancel",
                                                                   style: .cancel)
                  alert.addAction(cancelAction)
                present(alert, animated: true, completion: nil)
        }
        
        
        /*
        
        for i in extras {
            if i.name == hotbutton.titleLabel!.text! {
                check = 1
                 break
            } else {
                check = 2
                
            }
        }
        
        
        if check == 1 {
            
            
           
            
            
           // print("กด2 ")
            /*
                    if let index = extrabutton.index(where: { $0 == ["ร้อน","15"]}) {
                                   extrabutton.remove(at: index)
                        let extraItem = ExtraItem(name: "ร้อน",
                                                  price: "15")
                                
                             
                        let waterItemRef = self.ref.child("เครื่องดื่ม").child(waterid).child("ร้อน")
                          waterItemRef.setValue(extraItem.toAnyObject())
                                   hotbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
                               }else {
                                   extrabutton.append(["ร้อน","15"])
                          self.ref.child("เครื่องดื่ม").child(waterid).child("ร้อน").removeValue()
                                   hotbutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                               }
            */
        }
        
        else if check == 2 {
           print("อิหยังวะ")
                if let index = extrabutton.index(where: { $0 == ["ร้อน","15"]}) {
                    extrabutton.remove(at: index)
                    let extraItem = ExtraItem(name: "ร้อน",
                                               price: "15",
                                               status: "off")
                                                  
                                               
                                          let waterItemRef = self.ref.child("เครื่องดื่ม").child(waterid).child("ร้อน")
                                            waterItemRef.setValue(extraItem.toAnyObject())
                    hotbutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                }else {
                    extrabutton.append(["ร้อน","15"])
                 self.ref.child("เครื่องดื่ม").child(waterid).child("ร้อน").removeValue()
                    hotbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
                }
        }
        
            
        
   */
        
    }
    
    
    @IBAction func coldbtn(_ sender: Any) {
        if let index = extrabutton.index(where: { $0 == ["เย็น","0"]}) {
                   extrabutton.remove(at: index)
                   coldbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
        }else {
           extrabutton.append(["เย็น","0"])
            coldbutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
       
    }
    
    @IBAction func frappebtn(_ sender: Any) {
        if let index = extrabutton.index(where: { $0 == ["ปั่น","30"]}) {
                      extrabutton.remove(at: index)
                 frappebutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
           }else {
                extrabutton.append(["ปั่น","30"])
                frappebutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
           }
    }
    
}
