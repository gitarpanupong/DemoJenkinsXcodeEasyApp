//
//  NewFoodViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 22/7/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class NewFoodViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate  {
    
   var category: String = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    @IBOutlet weak var itemName1: UILabel!
    @IBOutlet weak var itemName2: UILabel!
    @IBOutlet weak var itemName3: UILabel!
    
    @IBOutlet weak var price1: UILabel!
    
    @IBOutlet weak var price2: UILabel!
    
    @IBOutlet weak var price3: UILabel!
    
    
    @IBOutlet weak var hotbutton: UIButton!
    
    @IBOutlet weak var coldbutton: UIButton!
    
    @IBOutlet weak var frappebutton: UIButton!
    
    
    
    @IBOutlet weak var imageViewFood: UIImageView!
    @IBOutlet weak var txtFoodName: UITextField!
    @IBOutlet weak var txtFoodPrice: UITextField!
    
    let button = UIButton(type: UIButton.ButtonType.custom)
    
    var type: String!
    
    var newFood = Food()
     var categoryID: String!
    var countfood: Int!
     var pickerData: [String] = [String] ()
    var foods: [FoodItem] = []
    let ref = Database.database().reference(withPath: "Food-items")
    
    @IBOutlet weak var pickerFood: UIPickerView!
    
    @IBOutlet weak var btn: UIButton!
    
      var extrabutton = [[String]]()
    
    @IBAction func hotbutton(_ sender: Any) {
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
           
    }
    
    
    @IBAction func coldbutton(_ sender: Any) {
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
    }
    
    
    @IBAction func frappebutton(_ sender: Any) {
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
    }
    
    
    
    @IBAction func btnSave(_ sender: UIButton) {
        ref.child("อาหาร").observe(.value, with: { (snapshot: DataSnapshot!) in
              print("จำนวนอาหาร ",snapshot.childrenCount)
            self.countfood = Int(snapshot.childrenCount)
          })

        self.saveData()
                
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        type = pickerData[row]
         
      //  type = type
        
    
    }
  
    
    var id: String!
    var match: Int!
     var check: Int!
    
    func saveData() {

        
       // let storageRef = Storage.storage().reference().child("Food").child(txtFoodName.text!.lowercased()+".jpg")
        
              let size = CGSize(width: 0, height: 0)
        
        switch Int((txtFoodName?.text!)!) {
                     case nil:
                           for i in self.foods {
                                       if i.name == txtFoodName?.text {
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

        if( txtFoodName.text!.isEmpty || imageViewFood.image?.size.width == size.width || self.match == 1 ){
            let alertController = UIAlertController(title: "ลองใหม่อีกครั้ง", message: "กรุณากรอกข้อมูลให้ครบถ้วน", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) {(action) in }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else{
            
              for i in self.extrabutton {
            let storageRef = Storage.storage().reference().child("Food").child(txtFoodName.text!.lowercased()+i[0]+".jpg")
                
                
                
            if let uploadData = imageViewFood.image!.pngData() {
                
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
                                
                                self.id = "Food "+String(self.countfood+1)
                
                                let foodItem = FoodItem(foodid: self.id,
                                                        name: String(self.txtFoodName.text!)+i[0],
                                                        price: i[1],
                                                        idcategory: self.categoryID,
                                                        category: self.type,
                                                        status: "on",
                                                        foodimage: url!.absoluteString,
                                                        foodimagepath: self.txtFoodName.text!+i[0]+".jpg")
                                let foodItemRef = self.ref.child("อาหาร").child(self.id)
                                foodItemRef.setValue(foodItem.toAnyObject())
                                print("eiei")
                                
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
            let foodViewController = self.navigationController?.topViewController as? FoodViewController
            foodViewController?.tableView?.reloadData()
            print("Save")
            
        }
   
        
        
    }

    override func viewDidLoad() {
        itemName1.isHidden = true
                  price1.isHidden = true
             
             itemName2.isHidden = true
                       price3.isHidden = true
             
             itemName3.isHidden = true
                       price3.isHidden = true
        
          
             
        hotbutton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                 coldbutton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
               frappebutton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
               
               hotbutton.layer.borderWidth = 2
                coldbutton.layer.borderWidth = 2
                frappebutton.layer.borderWidth = 2
               
               hotbutton.layer.cornerRadius = 15
                coldbutton.layer.cornerRadius = 15
                frappebutton.layer.cornerRadius = 15
               
        txtFoodPrice.isHidden = true
        super.viewDidLoad()
        btn.layer.cornerRadius = 15
        imageViewFood.layer.cornerRadius = 15
//        pickerFood.setValue(UIColor.white, forKeyPath: "textColor")
  //      pickerFood.layer.cornerRadius = 15
    //    pickerFood.layer.borderWidth = 2
      //  self.pickerFood.delegate = self
        //self.pickerFood.dataSource = self
        
        ref.child("อาหาร").observe(.value, with: { snapshot in
                 var newFoods: [FoodItem] = []
                 for child in snapshot.children {
                       print("child ",child)
                     if let snapshot = child as? DataSnapshot,
                         let foodItem = FoodItem(snapshot: snapshot) {
                         newFoods.append(foodItem)
                         
                     }
                 }
               
                 self.foods = newFoods
             //    self.tableView.reloadData()
                 
             })
        
        
      //  pickerData = ["อาหารตามสั่ง","ยำ","ซุป","ตำ","ทอด,เผา,ย่าง","เครื่องเคียง","ของหวาน"]
    
        pickerData = [category]
        
        
        dump(newFood)
        txtFoodPrice.delegate = self
         txtFoodName.delegate = self
        
        button.setTitle("Return", for: UIControl.State())
        button.setTitleColor(UIColor.black, for: UIControl.State())
        button.frame = CGRect(x: 0, y: 163, width: 106, height: 53)
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(NewFoodViewController.Done(_:)), for: UIControl.Event.touchUpInside)
        
        
        let tapGestureToImageView = UITapGestureRecognizer(target: self, action: #selector(tapToImageView(sender:)))
        tapGestureToImageView.numberOfTapsRequired = 1
        imageViewFood?.isUserInteractionEnabled = true
        imageViewFood?.addGestureRecognizer(tapGestureToImageView)

          //  pickerFood.selectRow(0, inComponent: 0, animated: true)
        type = category
        
    }
    
    func addTextField1(textField: UITextField!)
    {
        textField.placeholder = "Enter Food name"
        txtFoodName = textField
    }
    
    func addTextField2(textField: UITextField!)
    {
        textField.placeholder = "Enter Food Price"
        txtFoodPrice = textField
    }
    

    @objc func tapToImageView(sender: UITapGestureRecognizer){
        print("Tap to imageView")
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = .photoLibrary;
        self.present(pickerController, animated: false, completion: nil)
    }
    

    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage:UIImage = info[UIImagePickerController.InfoKey.originalImage]! as! UIImage
        imageViewFood!.image = chosenImage
        newFood.image = chosenImage
        picker.dismiss(animated: false, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if txtFoodName.isFirstResponder {
            txtFoodPrice.becomeFirstResponder()
        } else {
            txtFoodPrice.resignFirstResponder()
        }
        print("Press Return")
        return false
    }
    
  
    
     func textFieldDidEndEditing(_ textField: UITextField) {
          print("Press end")
       
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        newFood.foodName = txtFoodName.text ?? ""
        newFood.foodPrice = Int(txtFoodPrice.text ?? "")
        newFood.imageName = txtFoodName.text ?? ""
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
            
            self.txtFoodPrice.resignFirstResponder()
            
        }
    }

}


