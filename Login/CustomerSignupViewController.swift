//
//  CustomerSignupViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 18/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CustomerSignupViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var customerNametxt: UITextField!
    
    @IBOutlet weak var customerEmailtxt: UITextField!
    @IBOutlet weak var customerPasstxt: UITextField!
    
    var status: String!
    var pickerData: [String] = [String] ()
    
    @IBOutlet weak var pickerCustomer: UIPickerView!
    
      let ref = Database.database().reference(withPath: "Customer")
    
      var count : Int = 0
    
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
        status = pickerData[row]
    }


  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref.observe(.value, with: { (snapshot: DataSnapshot!) in
            self.count = Int(snapshot.childrenCount)
            print("จำนวนพนักงาน ",snapshot.childrenCount)
        })
        
       
        self.pickerCustomer.delegate = self
        self.pickerCustomer.dataSource = self
        
        
         pickerData = ["ห้องครัว","เคาน์เตอร์น้ำ"]

        // Do any additional setup after loading the view.
    }
    
    
//    @IBAction func signUpTapped(_ sender: Any) {
//
//        if let email = customerEmailtxt.text,let password = customerPasstxt.text,let name = customerNametxt.text{
//
//            Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
//                if let firebaseError = error {
//
//                    let alert = UIAlertView(title: "Warning!!!", message: firebaseError.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
//                    alert.show()
//                    print(firebaseError.localizedDescription)
//                    self.errorLabel.text = "Error! "
//                    self.errorTF.text = firebaseError.localizedDescription
//                    self.errorLabel.textColor = UIColor.red
//                    self.errorTF.textColor = UIColor.red
//                    print("error")
//                    return
//                } else {
//
//                    //let key = self.ref.childByAutoId().key
//                    let key = "Cus "+String(self.count+1)
//                    let customerData = CustomerItem(displayName: self.customerNametxt.text!,
//                                                email: self.customerEmailtxt.text!,
//                                                status: self.pickerCustomer.text!,
//                                                key: key as String)
//                    let customerItemRef = self.ref.child(key)
//                    //let memberItemRef = self.ref.child
//                    customerItemRef.setValue(customerData.toAnyObject())
//                    self.dismiss(animated: true, completion: nil)
//
//                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//                    changeRequest?.displayName = self.customerNametxt.text!
//                    changeRequest?.commitChanges { (error) in
//
//                    }
//
//
//                    self.errorLabel.text = "Create User"
//                    self.errorLabel.textColor = UIColor.green
//
//                    let alert = UIAlertView(title: "Sign Up Success!!!", message:"Welcome to EasyApp", delegate: nil, cancelButtonTitle: "OK")
//                    alert.show()
//                    print("Success!")
//                }
//
//
//            })
//
//
//        }
//
//    }
//
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorTF: UITextView!
    
    
    @IBAction func signUpbtn(_ sender: Any) {
                if let email = customerEmailtxt.text,let password = customerPasstxt.text,let name = customerNametxt.text{
        
                    Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
                        if let firebaseError = error {
        
                            let alert = UIAlertView(title: "Warning!!!", message: firebaseError.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
                            alert.show()
                            print(firebaseError.localizedDescription)
                            self.errorLabel.text = "Error! "
                            self.errorTF.text = firebaseError.localizedDescription
                            self.errorLabel.textColor = UIColor.red
                            self.errorTF.textColor = UIColor.red
                            print("error")
                            return
                        } else {
        
                            //let key = self.ref.childByAutoId().key
                            let key = "Cus "+String(self.count+1)
                            let customerData = CustomerItem(displayName: self.customerNametxt.text!,
                                                        email: self.customerEmailtxt.text!,
                                                        status: self.status,
                                                        key: key as String)
                            let customerItemRef = self.ref.child(key)
                            //let memberItemRef = self.ref.child
                            customerItemRef.setValue(customerData.toAnyObject())
                            self.dismiss(animated: true, completion: nil)
        
                            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                            changeRequest?.displayName = self.customerNametxt.text!
                            changeRequest?.commitChanges { (error) in
                            }
        
        
                            self.errorLabel.text = "Create User"
                            self.errorLabel.textColor = UIColor.green
        
                            let alert = UIAlertView(title: "เพิ่มบัญชีพนักงานเรียบร้อย", message:"ทำการเพิ่มบัญชีพนักงานเรียบร้อย", delegate: nil, cancelButtonTitle: "OK")
                            alert.show()
                            
                            self.navigationController?.popViewController(animated: true)
                            let CustomerViewController = self.navigationController?.topViewController as? CustomerViewController
                            
                           CustomerViewController?.tableView?.reloadData()
                            print("Success!")
                        }
        
        
                    })
        
        
                }
        
    }
    
 
}
