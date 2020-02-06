//
//  WaterNewViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 7/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class WaterNewViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate {

    var category: String = ""
    var categoryID: String!
    var countwater: Int!

    var type: String!
    var newWater = Water()
    
    var pickerData: [String] = [String] ()
    var waters: [WaterItem] = []
    let ref = Database.database().reference(withPath: "Food-items")
    var id :String!
    
    @IBOutlet weak var imageViewWater: UIImageView!
    @IBOutlet weak var txtWaterName: UITextField!
    @IBOutlet weak var txtWaterPrice: UITextField!
    
 
    @IBOutlet weak var itemName1: UILabel!
    
    @IBOutlet weak var itemName2: UILabel!
    
    @IBOutlet weak var itemName3: UILabel!
    
    @IBOutlet weak var price1: UILabel!
    
    @IBOutlet weak var price2: UILabel!
    @IBOutlet weak var price3: UILabel!
    //   @IBOutlet weak var pickerWater: UIPickerView!
        let button = UIButton(type: UIButton.ButtonType.custom)
    
    @IBOutlet weak var btn: UIButton!
    
    var typeextra : String = "type1"
    
    @IBAction func SegmentChange(_ sender: UISegmentedControl) {
        
        
        
        if sender.selectedSegmentIndex == 0 {
        
                typeextra = "type1"
            
            
            
            hotbutton.titleLabel?.text = "ร้อน"
            coldbutton.titleLabel?.text = "เย็น"
            frappebutton.titleLabel?.text = "ปั่น"
            
            
        }else {
             typeextra = "type2"
            hotbutton.titleLabel?.text = "S"
            coldbutton.titleLabel?.text = "M"
            frappebutton.titleLabel?.text = "L"
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemName1.isHidden = true
             price1.isHidden = true
        
        itemName2.isHidden = true
                  price3.isHidden = true
        
        itemName3.isHidden = true
                  price3.isHidden = true
        txtWaterPrice.isHidden = true
        
        
        hotbutton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
          coldbutton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        frappebutton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        hotbutton.layer.borderWidth = 2
         coldbutton.layer.borderWidth = 2
         frappebutton.layer.borderWidth = 2
        
        hotbutton.layer.cornerRadius = 15
         coldbutton.layer.cornerRadius = 15
         frappebutton.layer.cornerRadius = 15
        
        ref.child("เครื่องดื่ม").observe(.value, with: { snapshot in
            var newWaters: [WaterItem] = []
            for child in snapshot.children {
                  print("child ",child)
                if let snapshot = child as? DataSnapshot,
                    let waterItem = WaterItem(snapshot: snapshot) {
                    newWaters.append(waterItem)
                    
                }
            }
          
            self.waters = newWaters
        //    self.tableView.reloadData()
            
        })
        
            btn.layer.cornerRadius = 15
           imageViewWater.layer.cornerRadius = 15
       //    pickerWater.layer.cornerRadius = 15
         //  pickerWater.layer.borderWidth = 2
        
    //    self.pickerWater.delegate = self
      //  self.pickerWater.dataSource = self
        
       // pickerData = ["น้ำ","น้ำอัดลม","น้ำผลไม้","ชา กาแฟ"]
        
   //     pickerData = [category]
        
        dump(newWater)
        txtWaterPrice.delegate = self
        txtWaterName.delegate = self
        
        
        
        
        button.setTitle("Return", for: UIControl.State())
        button.setTitleColor(UIColor.black, for: UIControl.State())
        button.frame = CGRect(x: 0, y: 163, width: 106, height: 53)
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(NewFoodViewController.Done(_:)), for: UIControl.Event.touchUpInside)
        
        let tapGestureToImageView = UITapGestureRecognizer(target: self, action: #selector(tapToImageView(sender:)))
        tapGestureToImageView.numberOfTapsRequired = 1
        imageViewWater?.isUserInteractionEnabled = true
        imageViewWater?.addGestureRecognizer(tapGestureToImageView)
        
        type = category
    }
    

    @IBAction func btnSave(_ sender: Any) {
        ref.child("เครื่องดื่ม").observe(.value, with: { (snapshot: DataSnapshot!) in
                   print("จำนวนอาหาร ",snapshot.childrenCount)
                 self.countwater = Int(snapshot.childrenCount)
               })

          self.saveData()
    }
    
    var match: Int!
    
    func saveData() {
        
         let size = CGSize(width: 0, height: 0)
        
        switch Int((txtWaterName?.text!)!) {
                            case nil:
                                  for i in self.waters {
                                              if i.name == txtWaterName?.text {
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

        
        
        if( txtWaterName.text!.isEmpty  || imageViewWater.image?.size.width == size.width || self.match == 1 || extrabutton == nil ){
            let alertController = UIAlertController(title: "Alert", message: "Please set waterName, waterPrice, choose image", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) {(action) in }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else{
        for i in self.extrabutton {
            
            let storageRef = Storage.storage().reference().child("Water").child(txtWaterName.text!+i[0]+".jpg")
                 
             
            if let uploadData = imageViewWater.image!.pngData() {
                
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
                                
     
                                                                    
                            

                                                                
                                self.id = "Water "+String(self.countwater+1)
                                
                                let waterItem = WaterItem(waterid: self.id,
                                                        name: String(self.txtWaterName.text!)+i[0],
                                                        price: i[1],//self.txtWaterPrice.text!,
                                                        idcategory: self.categoryID,
                                                        category: self.type,
                                                        status: "on",
                                                        waterimage: url!.absoluteString,
                                                        waterimagepath: self.txtWaterName.text!+i[0]+".jpg")
                                
                                let waterItemRef = self.ref.child("เครื่องดื่ม").child(self.id)
                                waterItemRef.setValue(waterItem.toAnyObject())
                               
                             
                                         /*
                                           let extraItem = ExtraItem(name: String(i[0]),
                                                                     price: String(i[1]),
                                                                         status: "on")
                                                           

                                           let waterItemRef = self.ref.child("เครื่องดื่ม").child(self.id).child(i[0])
                                           waterItemRef.setValue(extraItem.toAnyObject())*/

                                       

                                
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
            
        }
            
       
            
            navigationController?.popViewController(animated: false)
            let waterViewController = self.navigationController?.topViewController as? WaterViewController
            waterViewController?.tableView?.reloadData()
            print("Save")
            
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
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage:UIImage = info[UIImagePickerController.InfoKey.originalImage]! as! UIImage
        imageViewWater!.image = chosenImage
        newWater.image = chosenImage
        picker.dismiss(animated: true, completion: nil)
        print("eiei")
        
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        type = pickerData[row]
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if txtWaterName.isFirstResponder {
            txtWaterPrice.becomeFirstResponder()
        } else {
            txtWaterPrice.resignFirstResponder()
        }
        print("Press Return")
        return false
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Press end")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        newWater.waterName = txtWaterName.text ?? ""
        newWater.waterPrice = Int(txtWaterPrice.text ?? "")
        newWater.imageName = txtWaterName.text ?? ""
        textField.resignFirstResponder()
    }
    
    
    @objc func keyboardWillShow(_ note : Notification) -> Void{
        DispatchQueue.main.async { () -> Void in
            self.button.isHidden = false
            let keyBoardWindow = UIApplication.shared.windows.last
            self.button.frame = CGRect(x: 0, y: (keyBoardWindow?.frame.size.height)!-53, width: 106, height: 53)
            keyBoardWindow?.addSubview(self.button)
            keyBoardWindow?.bringSubviewToFront(self.button)
            
            UIView.animate(withDuration: (((note.userInfo! as NSDictionary).object(forKey: UIResponder.keyboardAnimationCurveUserInfoKey) as AnyObject).doubleValue)!, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
                self.view.frame = self.view.frame.offsetBy(dx: 0, dy: 0)
            }, completion: { (complete) -> Void in
                print("Complete")
            })
        }
        
    }
    
    @objc func Done(_ sender : UIButton){
        
        DispatchQueue.main.async { () -> Void in
            
            self.txtWaterPrice.resignFirstResponder()
            
        }
    }
    
    var extrabutton = [[String]]()
    var countextrabutton: Int = 0
    
   
    
    
    @IBOutlet weak var hotbutton: UIButton!
    
    @IBOutlet weak var coldbutton: UIButton!
    
    @IBOutlet weak var frappebutton: UIButton!
    
    
    
    
    @IBAction func hotbtn(_ sender: Any) {
        
        
        if let index = extrabutton.index(where: { $0 == [itemName1.text,price1.text]}) {
                       extrabutton.remove(at: index)
                    hotbutton.setTitle("เพิ่ม",for: .normal)
            itemName1.isHidden = true
            price1.isHidden = true
                        hotbutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
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
            self.hotbutton.setTitle("ลบ",for: .normal)
            self.itemName1.isHidden = false
            self.price1.isHidden = false
            self.itemName1.text = textField?.text
            self.price1.text = textField2?.text
            
            self.hotbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
        
        }))
        let cancelAction = UIAlertAction(title: "Cancel",
                                                               style: .cancel)
              alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
               
                       
     
         }
        
        
        
        
        
        
        /*
        
        if typeextra == "type1"{
            if let index = extrabutton.index(where: { $0 == ["ร้อน","-5"]}) {
                extrabutton.remove(at: index)
                  hotbutton.setTitle("ร้อน",for: .normal)
                hotbutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            
            }else {
                extrabutton.append(["ร้อน","-5"])
                 hotbutton.setTitle("ร้อน",for: .normal)
                hotbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
            }
        }
        else if typeextra == "type2"{
               if let index = extrabutton.index(where: { $0 == ["เล็ก","-5"]}) {
                   extrabutton.remove(at: index)
                     hotbutton.setTitle("S",for: .normal)
                   hotbutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
               
               }else {
                   extrabutton.append(["เล็ก","-5"])
                  //  hotbutton.titleLabel?.text = "S"
                hotbutton.setTitle("S",for: .normal)
                   hotbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
               }
           }*/
    print(typeextra," typeextra ",extrabutton)
    }
    
    @IBAction func coldbtn(_ sender: Any) {
        
        if let index = extrabutton.index(where: { $0 == [itemName2.text,price2.text]}) {
                            extrabutton.remove(at: index)
                         coldbutton.setTitle("เพิ่ม",for: .normal)
                 itemName2.isHidden = true
                 price2.isHidden = true
                             coldbutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
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
                 self.coldbutton.setTitle("ลบ",for: .normal)
                 self.itemName2.isHidden = false
                 self.price2.isHidden = false
                 self.itemName2.text = textField?.text
                 self.price2.text = textField2?.text
                 
                 self.coldbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
             
             }))
             let cancelAction = UIAlertAction(title: "Cancel",
                                                                    style: .cancel)
                   alert.addAction(cancelAction)
                 present(alert, animated: true, completion: nil)
                    
                            
          
              }
        
        
        /*
          if typeextra == "type1"{
                if let index = extrabutton.index(where: { $0 == ["เย็น","0"]}) {
                   extrabutton.remove(at: index)
                    coldbutton.setTitle("เย็น",for: .normal)
                   coldbutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                }else {
                    extrabutton.append(["เย็น","0"])
                     coldbutton.setTitle("เย็น",for: .normal)
                    coldbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
                }
        }
            
          else if typeextra == "type2"{
                if let index = extrabutton.index(where: { $0 == ["กลาง","0"]}) {
                   extrabutton.remove(at: index)
                    coldbutton.setTitle("M",for: .normal)
                   coldbutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                }else {
                    extrabutton.append(["กลาง","0"])
                  coldbutton.setTitle("M",for: .normal)
                    coldbutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
                }
        }
          print(typeextra," typeextra ",extrabutton)*/
        
    }
    

    @IBAction func frappebtn(_ sender: Any) {
       // extrabutton[0].append("ปั่น")
      //   extrabutton[1].append("30")
         
        if let index = extrabutton.index(where: { $0 == [itemName3.text,price3.text]}) {
                            extrabutton.remove(at: index)
                         frappebutton.setTitle("เพิ่ม",for: .normal)
                 itemName3.isHidden = true
                 price3.isHidden = true
                    frappebutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
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
                 self.frappebutton.setTitle("ลบ",for: .normal)
                 self.itemName3.isHidden = false
                 self.price3.isHidden = false
                 self.itemName3.text = textField?.text
                 self.price3.text = textField2?.text
                 
                 self.frappebutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
             
             }))
             let cancelAction = UIAlertAction(title: "Cancel",
                                                                    style: .cancel)
                   alert.addAction(cancelAction)
                 present(alert, animated: true, completion: nil)
                    
                            
          
              }
        
        
        /*
           if typeextra == "type1"{
        
                    if let index = extrabutton.index(where: { $0 == ["ปั่น","10"]}) {
                            extrabutton.remove(at: index)
                        frappebutton.setTitle("ปั่น",for: .normal)
                            frappebutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                    }else {
                            extrabutton.append(["ปั่น","10"])
                         frappebutton.setTitle("ปั่น",for: .normal)
                            frappebutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
                    }
            }
            else if typeextra == "type2"{
             
                if let index = extrabutton.index(where: { $0 == ["ใหญ่","10"]}) {
                        extrabutton.remove(at: index)
                     frappebutton.setTitle("L",for: .normal)
                        frappebutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                }else {
                        extrabutton.append(["ใหญ่","10"])
                   
                        frappebutton.setTitle("L",for: .normal)
                        frappebutton.backgroundColor = #colorLiteral(red: 0.9390417933, green: 0.3196231723, blue: 0.3215077519, alpha: 1)
                }
            }
        
          print(typeextra," typeextra ",extrabutton)
 */
    }
    

}
