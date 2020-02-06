//
//  RestaurantViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 30/10/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class RestaurantViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
   //   var newInfo = Food()
       let button = UIButton(type: UIButton.ButtonType.custom)
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UITextField!
    @IBOutlet weak var restaurantPlace: UITextField!
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var restaurantTime: UITextField!
    
    @IBOutlet weak var restaurantTimr2: UITextField!
    @IBOutlet weak var savebtn: UIButton!
    
     let ref = Database.database().reference(withPath: "Restaurant")
    
    var infos: [RestaurantItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
     
        
         restaurantImage.layer.cornerRadius = 10
         savebtn.layer.cornerRadius = 10
         self.savebtn.isHidden = false
        
        let tapGestureToImageView = UITapGestureRecognizer(target: self, action: #selector(tapToImageView(sender:)))
             tapGestureToImageView.numberOfTapsRequired = 1
             restaurantImage?.isUserInteractionEnabled = true
             restaurantImage?.addGestureRecognizer(tapGestureToImageView)
             
        
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
    
    var match: Int!
    
    @IBAction func SaveResInfo(_ sender: Any) {
         self.saveData()
    }
    
    
    func saveData() {

        let storageRef = Storage.storage().reference().child("Info").child(restaurantName.text!.lowercased()+".jpg")
        
           let size = CGSize(width: 0, height: 0)
        
    if( restaurantName.text!.isEmpty || restaurantPlace.text!.isEmpty || Phone.text!.isEmpty || restaurantTime.text!.isEmpty || restaurantImage.image?.size.width == size.width || self.match == 1 ){
                  let alertController = UIAlertController(title: "ลองใหม่อีกครั้ง", message: "กรุณากรอกข้อมูลให้ครบถ้วน", preferredStyle: .alert)
                  let okAction = UIAlertAction(title: "OK", style: .default) {(action) in }
                  alertController.addAction(okAction)
                  self.present(alertController, animated: false, completion: nil)
            } else{
        
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
                                                        phone: self.Phone.text!,
                                                        resimage: url!.absoluteString,
                                                        resimagepath: self.restaurantName.text!.lowercased()+".jpg")
                            let resItemRef = self.ref//.child("res 1")
                            resItemRef.setValue(infos.toAnyObject())
                            
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
        
        // let size = CGSize(width: 0, height: 0)
        

        navigationController?.popViewController(animated: false)
        let resViewController = self.navigationController?.topViewController as? ResViewController
        resViewController?.tableView?.reloadData()
        print("Save")
        
            
        }
//        switch (Int((restaurantName?.text!)!) != nil) ||  (Int((restaurantPlace?.text!)!) != nil)  {
//                               case nil:
//
//                                   self.match = 0
//
//                               default:
//                                   self.match = 1
//       }

        
//        if( restaurantName.text!.isEmpty || restaurantPlace.text!.isEmpty || Phone.text!.isEmpty || restaurantTime.text!.isEmpty || restaurantImage.image?.size.width == size.width){
//            let alertController = UIAlertController(title: "Alert", message: "Please set foodName, foodPrice, choose image", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default) {(action) in }
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//        } else{
//            navigationController?.popViewController(animated: true)
//          let saveAction = UIAlertAction(title: "Save", style: .default)
//
//            print("Save")
//
//        }

    }
    

//      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//          if restaurantName.isFirstResponder {
//              restaurantPlace.becomeFirstResponder()
//          } else {
//              restaurantPlace.resignFirstResponder()
//          }
//          print("Press Return")
//          return false
//      }
//
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
       textField.resignFirstResponder()
       return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
          print("Press end")
       
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
//        newFood.foodName = restaurantName.text ?? ""
//        newFood.foodPrice = Int(txtFoodPrice.text ?? "")
//        newFood.imageName = txtFoodName.text ?? ""
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
      
      
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
