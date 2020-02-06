//
//  HomeLoginViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 5/8/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class HomeLoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    //@IBOutlet weak var errorTF: UITextField!
    @IBOutlet weak var errorTF: UITextView!
    
    //let ref = Database.database().reference(withPath: "member")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
       self.parent?.title = "เข้าสู่ระบบ"
        // Do any additional setup after loading the view.
    }
   
    
    
    @IBAction func loginTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: usernameTextfield.text!, password: passwordTextfield.text!) { [weak self] user, error in
            
            if let firebaseError = error {
                print(firebaseError.localizedDescription)
                self?.errorTF.text = firebaseError.localizedDescription
                self?.errorTF.textColor = UIColor.red
                print("error")
                return
            } else {
                let ref = Database.database().reference(withPath: "Member")
               /* let query = ref.queryOrdered(byChild: "email").queryEqual(toValue: self!.usernameTextfield.text!)
                
                print(query)*/
                
              
                 ref.queryOrdered(byChild: "email").queryEqual(toValue: self!.usernameTextfield.text!).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if snapshot.exists() {
                        
                        self?.errorTF.isHidden = true
                        print("Success!")
                        self!.performSegue(withIdentifier: "customerLogin", sender: self)
                        
                    }else{
                        
                        print("User doesn't exist")
                        self?.errorTF.text = "Please Sign up!"
                        self?.errorTF.textColor = UIColor.red
                        return
                    }
                    
                    
                })
                
               
              
            }
        }
        
    }
    


}
