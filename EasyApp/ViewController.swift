//
//  ViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 2/8/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class ViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var OpenMenu: UIBarButtonItem!
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UITextField!
    @IBOutlet weak var restaurantPlace: UITextField!
    @IBOutlet weak var restaurantPhone: UITextField!
    @IBOutlet weak var restaurantTime: UITextField!
    
    @IBOutlet weak var restaurantTime2: UITextField!
    
    // @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    let ref = Database.database().reference()
     //let ref = Database.database().reference(withPath: "Infomation")
    
    let refBillitems = Database.database().reference(withPath: "Infomation")
    
    var infos: [RestaurantItem] = []
     var resname : String = ""
     var resplace : String = ""
     var resphone : String = ""
     var restime : String = ""
  
    override func viewDidLoad() {
        
        restaurantImage.layer.cornerRadius = 10
     //   saveButton.layer.cornerRadius = 10
       

      //  self.saveButton.isHidden = true
     //   self.editButton.isHidden = true
        
        OpenMenu.target = self.revealViewController()
        OpenMenu.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        let tapGestureToImageView = UITapGestureRecognizer(target: self, action: #selector(tapToImageView(sender:)))
        tapGestureToImageView.numberOfTapsRequired = 1
        restaurantImage?.isUserInteractionEnabled = true
        restaurantImage?.addGestureRecognizer(tapGestureToImageView)
        
//        ref.child("Restaurant").observe(.value, with: { (snapshot) in
//
//               if let value = snapshot.value as? [String: Any] {
//                   self.resname = value["name"] as? String ?? ""
//                   self.resplace = value["place"] as? String ?? ""
//                  self.resphone = value["phone"] as? String ?? ""
//                  self.restime = value["time"] as? String ?? ""
//
//               }
//               self.tableView.reloadData()
//           })
//
        ref.child("Restaurant").observe(.value, with: { snapshot in
            if(snapshot.childrenCount > 0){
                //ข้อมูลไม่ว่างจะเข้าการแก้ไข
                print("Not Empty")
                
            //    self.saveButton.isHidden = true
             //   self.editButton.isHidden = false
            //    self.deleteButton.isHidden = false
                 if let value = snapshot.value as? [String: Any] {
                    self.resname = value["name"] as? String ?? ""
                    self.resplace = value["place"] as? String ?? ""
                    self.resphone = value["phone"] as? String ?? ""
                    self.restime = value["time"] as? String ?? ""
                }
                
//                var dataArr: [RestaurantItem] = []
//                for child in snapshot.children {
//                    print("Yes ")
//                    if let snapshot = child as? DataSnapshot,
//                        let cateData = RestaurantItem(snapshot: snapshot) {
//                        print("cateData ",cateData)
//                        dataArr.append(cateData)
//                    }
//                }
//
//                self.infos = dataArr
                
                self.restaurantName.text = self.resname
                self.restaurantPlace.text = self.resplace
                self.restaurantPhone.text = self.resphone
                self.restaurantTime.text = self.restime
                
                let imageRef = Storage.storage().reference().child("Info").child(self.resname.lowercased()+".jpg")
                imageRef.getData(maxSize: 100*1024*1024, completion: { (data, error) -> Void  in
                    
                   
                    
                    if error == nil {
                        print("Data")
                        print(data)
                         self.restaurantImage?.image = UIImage(data: data!)
                        
                        //print(error?.localizedDescription)
                        
                    } else {
                        
                        print("error")
                        //  print(data)
                        print(error?.localizedDescription)
                        
                    }
                    
                })
                
            }
            
            else{
                
                //ข้อมูลว่าง จะเซฟข้อมูล
            //    self.saveButton.isHidden = false
               // self.editButton.isHidden = true
               //  self.deleteButton.isHidden = true
                
                self.restaurantName.placeholder = "ยังไม่เพิ่มข้อมูลร้าน"
                self.restaurantPlace.placeholder = "ยังไม่เพิ่มข้อมูลร้าน"
                self.restaurantPhone.placeholder = "ยังไม่เพิ่มข้อมูลร้าน"
                self.restaurantTime.placeholder = "ยังไม่เพิ่มข้อมูลร้าน"
                
            }
            
            
            
        })
        
        
        
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
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
        restaurantImage!.image = chosenImage
       // newFood.image = chosenImage
        picker.dismiss(animated: false, completion: nil)
        print("eiei")
        
    }
    @IBAction func EditResInfo(_ sender: Any) {
        print("Edit")
         self.editData()
    }
    @IBAction func deletebtn(_ sender: Any) {
        ref.removeValue()
    }
    
   func editData() {
    
    let storageRef = Storage.storage().reference().child("Info").child(self.restaurantName.text!.lowercased()+".jpg")
    
    let size = CGSize(width: 0, height: 0)
    
    if( restaurantName.text!.isEmpty || restaurantPlace.text!.isEmpty || restaurantPhone.text!.isEmpty || restaurantTime.text!.isEmpty || restaurantImage.image?.size.width == size.width ){
                  let alertController = UIAlertController(title: "ลองใหม่อีกครั้ง", message: "กรุณากรอกข้อมูลให้ครบถ้วน", preferredStyle: .alert)
                  let okAction = UIAlertAction(title: "OK", style: .default) {(action) in }
                  alertController.addAction(okAction)
                  self.present(alertController, animated: false, completion: nil)
            }
    else {
    if let uploadData = restaurantImage.image!.pngData() {
        
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
                        
        
            self.ref.child("Restaurant").updateChildValues([
            "name": self.restaurantName.text!,
            "phone": self.restaurantPhone.text!,
            "place": self.restaurantPlace.text!,
            "time": self.restaurantTime.text!,
            "resimagepath": self.restaurantName.text!+".jpg",
            "resimage": url!.absoluteString
            ])
                    }
                }else {
                        print("Error ")
                    }
    })
            
            })
        }
        
    }
    
     //   self.viewDidLoad()
    }

    /*
    @IBAction func SaveResInfo(_ sender: Any) {
          print("Save")
        self.saveData()
    }
    
    func saveData() {

        let storageRef = Storage.storage().reference().child("Info").child(restaurantName.text!.lowercased()+".jpg")
        
        if let uploadData = restaurantImage.image!.pngData() {
            
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
                            
                            let infos = RestaurantItem(resid: "res 1",
                                                        name: self.restaurantName.text!,
                                                        place: self.restaurantPlace.text!,
                                                        time: self.restaurantTime.text!,
                                                        phone: self.restaurantPhone.text!,
                                                        resimage: url!.absoluteString,
                                                        resimagepath: self.restaurantName.text!.lowercased()+".jpg")
                            let resItemRef = self.ref.child("ข้อมูลร้าน")
                            resItemRef.setValue(infos.toAnyObject())
                            print("eiei")
                            
                            
                            print(downloadString)
                        }
                    } else {
                        print("Error ")
                    }
                })

                print("ข้าม")
                
                print(metadata)
            })
        }
        
        let size = CGSize(width: 0, height: 0)
        
        if( restaurantName.text!.isEmpty || restaurantPlace.text!.isEmpty || restaurantPhone.text!.isEmpty || restaurantTime.text!.isEmpty || restaurantImage.image?.size.width == size.width){
            let alertController = UIAlertController(title: "Alert", message: "Please set foodName, foodPrice, choose image", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) {(action) in }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else{
            navigationController?.popViewController(animated: true)
          let saveAction = UIAlertAction(title: "Save", style: .default)
           
            print("Save")
            
        }

    }
    */
    @IBAction func deleteData(_ sender: Any) {
       
     //  ref.removeValue()
        refBillitems.removeValue()
        
        let alertController = UIAlertController(title: "ยืนยัน", message: "ลบข้อมูลเรียบร้อย", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) {(action) in }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        self.viewDidLoad()
        
        self.restaurantName.placeholder = "ยังไม่เพิ่มข้อมูลร้าน"
                      self.restaurantPlace.placeholder = "ยังไม่เพิ่มข้อมูลร้าน"
                      self.restaurantPhone.placeholder = "ยังไม่เพิ่มข้อมูลร้าน"
                      self.restaurantTime.placeholder = "ยังไม่เพิ่มข้อมูลร้าน"
        
        let imageRef = Storage.storage().reference().child("Info").child(self.restaurantName.text!.lowercased())
        imageRef.delete(completion: {(error)  -> Void  in
            if error == nil {
                print("Delete Success")
                
            }
        })
        
        
        
    }
    

}
