//
//  DetailFoodViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 1/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class DetailFoodViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var name : String!
    var img : String!
    var price : String!
    var typename : String!
    var category : String!
    var foods: [FoodItem] = []
    
     let ref = Database.database().reference(withPath: "Food-items")
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var showImg: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showImg.contentMode = UIView.ContentMode.scaleToFill
        showImg.layer.borderWidth = 5
        showImg.layer.cornerRadius = 15
        
        showImg.layer.borderColor = UIColor.darkGray.cgColor
    
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
        
        
        txtName.text = name
        txtPrice.text = price
        //let imgData = try? Data(contentsOf: img as! URL)
        //showImg.image = UIImage(data: imgData!)
        let tapGestureToImageView = UITapGestureRecognizer(target: self, action: #selector(tapToImageView(sender:)))
        tapGestureToImageView.numberOfTapsRequired = 1
        showImg?.isUserInteractionEnabled = true
        showImg?.addGestureRecognizer(tapGestureToImageView)
        
        
        let imageRef = Storage.storage().reference().child("Food").child(self.txtName.text!.lowercased()+".jpg")
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
        

        // Do any additional setup after loading the view.
    }
    
    var match: Int!

    @IBAction func btnSave(_ sender: Any) {
        //navigationController?.popViewController(animated: true)
        
        let storageRef = Storage.storage().reference().child("Food").child(txtName.text!.lowercased()+".jpg")
        
        let size = CGSize(width: 0, height: 0)
        
        
        switch Int((txtName?.text!)!) {
                            case nil:
                                  for i in self.foods {
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

        
        
        if( txtName.text!.isEmpty || txtPrice.text!.isEmpty || showImg.image?.size.width == size.width || match == 1){
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
//                            
//                            let foodItem = FoodItem(name: self.txtName.text!,
//                                                    price: self.txtPrice.text!,
//                                                    category: self.category,
//                                                    foodimage: url!.absoluteString)
                            
                            self.ref.child("อาหาร").queryOrdered(byChild: "name").queryEqual(toValue: self.name).observeSingleEvent(of: .value, with: { snapshot in
                                
                                for child in snapshot.children{
                                    let DataSnap = child as! DataSnapshot
                                    let getid = DataSnap.key
                                    
                                    self.ref.child("อาหาร").child(getid).updateChildValues(["name": self.txtName.text,
                                                                                             "price": self.txtPrice.text!,
                                                                                            "category": self.category,
                                                                                            "foodimage": url!.absoluteString,
                                                                                            "foodimagepath": self.txtName.text!+".jpg"])
                                    

                                    
                                    
                                   // let foodItemRef = self.ref.child(self.category.lowercased()).child(snapshot.key)
                                   //foodItemRef.setValue(foodItem.toAnyObject())
                             
                                    
                                    
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
        

        navigationController?.popViewController(animated: true)
        let foodViewController = self.navigationController?.topViewController as? FoodViewController
        foodViewController?.tableView?.reloadData()
        print("Save")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backshowFood" {
            // Get SecondVC
            let showFood = segue.destination as! FoodViewController
            
            // Pass text to SecondVC
            showFood.categoryName = category
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
    
      var newFood = Food()
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage:UIImage = info[UIImagePickerController.InfoKey.originalImage]! as! UIImage
        showImg!.image = chosenImage
        newFood.image = chosenImage
        picker.dismiss(animated: true, completion: nil)
        print("eiei")
    }

    

}
