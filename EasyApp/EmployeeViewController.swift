//
//  EmployeeViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 9/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class EmployeeViewController: UIViewController {
    
    @IBOutlet weak var namelbl: UILabel!
    
    @IBOutlet weak var emaillbl: UITextField!
    
    @IBOutlet weak var usernametxt: UITextField!
    @IBOutlet weak var useremailtxt: UITextField!
    
    let userid = Auth.auth().currentUser
    var count : Int! = 0
    
    
    
    
    let ref = Database.database().reference(withPath: "Employee")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if count == 0 {

            namelbl.text = "ชื่อ - สกุล"
            emaillbl.text = "อีเมล"
            self.ref.queryOrdered(byChild: "email").queryEqual(toValue: self.userid?.email).observe(.value, with: { snapshot in
                for child in snapshot.children{
                    let DataSnap = child as! DataSnapshot
                    let getid = DataSnap.key //หมาย
                    
                }
            })
            usernametxt.text = userid?.displayName!
            print("ข้อมูล ",userid?.displayName)
            useremailtxt.text = userid?.email!
            print("เมล ",userid?.email!)
            
        } else {
            namelbl.text = "รหัสผ่าน"
            emaillbl.text = "ยืนยันรหัสผ่าน"
            
            usernametxt.text = ""
            useremailtxt.text = ""

        }
        
        
    }
    

    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
            count = 0
            self.viewDidLoad()
            
            
        }
        else if sender.selectedSegmentIndex == 1 {
            count = 1
            
            self.viewDidLoad()
        }
        
        
        
    }
    
    @IBAction func savebtn(_ sender: Any) {
        
        if count == 0 {
            
            
            
            if usernametxt.text == "" || useremailtxt.text == ""  {
                var alert = UIAlertController(title: "ไม่สามารถอัพเดทได้", message: "กรุณากรอกข้อมูลเพื่ออัพเดท", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                if useremailtxt.text != "" {
                    
                    userid!.updateEmail(to: useremailtxt.text!) { error in
                        if let error = error{
                            var alert = UIAlertController(title: "ไม่สามารถอัพเดทได้", message: "ไม่สามารถอัพเดทอีเมลได้", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else {
                            self.ref.queryOrdered(byChild: "email").queryEqual(toValue: self.userid?.email).observe(.value, with: { snapshot in
                                for child in snapshot.children{
                                    let DataSnap = child as! DataSnapshot
                                    let getid = DataSnap.key //หมาย
                                    print("keyy ",getid)
                                    self.ref.child(getid).updateChildValues(["email" : self.useremailtxt.text])
                                }
                            })
                            print("update Email")
                        }
                        
                    }
                }
                
                if usernametxt.text != "" {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = self.usernametxt.text!
                    changeRequest?.commitChanges { (error) in
                        if let error = error{
                            var alert = UIAlertController(title: "ไม่สามารถอัพเดทได้", message: "ไม่สามารถอัพเดทชื่อได้", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else{
                            self.ref.queryOrdered(byChild: "email").queryEqual(toValue: self.userid?.email).observe(.value, with: { snapshot in
                                for child in snapshot.children{
                                    let DataSnap = child as! DataSnapshot
                                    let getid = DataSnap.key //หมาย
                                    self.ref.child(getid).updateChildValues(["displayName" : self.usernametxt.text])
                                    
                                }
                            })
                        }
                        
                    }
                    var alert = UIAlertController(title: "เรียบร้อย", message: "อัพเดทข้อมูลเรียบร้อย", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                
            }
            
            
            
        } else if count == 1 {
            // usernametxt.text = ""
            // useremailtxt.text = ""
            
            
            if usernametxt.text == "" || useremailtxt.text == "" {
                var alert = UIAlertController(title: "ไม่สามารถอัพเดทได้", message: "กรุณากรอกข้อมูลเพื่อให้ครบ", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                print("เข้าไหม ")
                if usernametxt.text == useremailtxt.text {
                    userid!.updatePassword(to: useremailtxt.text!) { error in
                        if let error = error{
                            var alert = UIAlertController(title: "ไม่สามารถอัพเดทได้", message: "ไม่สามารถอัพเดทรหัสผ่านได้", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else {
                            var alert = UIAlertController(title: "เรียบร้อย", message: "อัพเดทรหัสผ่านเรียบร้อย", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                }
                else {
                    var alert = UIAlertController(title: "รหัสผ่านไม่ตรงกัน", message: "กรุณากรอกรหัสผ่านให้ตรงกัน", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            
        }
        
    }
    


    }
    
    

    


