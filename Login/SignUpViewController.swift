//
//  SignUpViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 5/8/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController{
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var errorTF: UITextView!
    
    var authListener: AuthStateDidChangeListenerHandle?
    
    
    var count : Int = 0
    
    //var ref = Database.database().reference(withPath: "User")
    
    let ref = Database.database().reference(withPath: "Member")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref.observe(.value, with: { (snapshot: DataSnapshot!) in
            self.count = Int(snapshot.childrenCount)
            print("จำนวนคน ",snapshot.childrenCount)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        authListener = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let _ = user {
                print("Test")
            }
        })
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        performSegue(withIdentifier: "HomeLoginViewController", sender: self)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       Auth.auth().removeStateDidChangeListener(authListener!)
    }

    @IBAction func signUpTapped(_ sender: Any) {
      
       // let email = emailTextField.text!
        //let password = passwordTextField.text!
   
        if let email = emailTextField.text,let password = passwordTextField.text,let name = nameTextField.text{
            
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
                    let key = "Mem "+String(self.count+1)
                    let memberData = MemberItem(displayName: self.nameTextField.text!,
                                                email: self.emailTextField.text!,
                                                key: key as String)
                    let memberItemRef = self.ref.child(key)
                    //let memberItemRef = self.ref.child
                    memberItemRef.setValue(memberData.toAnyObject())
                    self.dismiss(animated: true, completion: nil)
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = self.nameTextField.text!
                    changeRequest?.commitChanges { (error) in
                        
                    }
                    
                    
                    self.errorLabel.text = "Create User"
                    self.errorLabel.textColor = UIColor.green
                    
                    let alert = UIAlertView(title: "Sign Up Success!!!", message:"Welcome to EasyApp", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                    print("Success!")
                }
                
                
               
                
              
                
            //    let ref = Database.database().referrence
              
                
                /*if (error != nil) {
                    self.errorLabel.text = "Error! Please try Again!"
                    self.errorLabel.textColor = UIColor.red
                    print("error")
                    
                }else{
                    self.errorLabel.text = "User Created!"
                    self.errorLabel.textColor = UIColor.green
                    print("Create User")
                }*/
            
            
        })
     
            
        }
    
        /*  guard let firstname = firstNameTextField.text else { return }
        guard let lastname = lastNameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        
        
        signUpButton.setTitle("", for: .normal)
        
        Auth.auth().createUser(withEmail: email, password: password){ user,error in
            if error == nil && user != nil {
                print("User Create!")
            } else {
                print("Error creating user: \(error!.localizedDescription)")
            }
         
        }*/
        
        
       /* Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {
            (user, error) in
            
            if user != nil{
                print("Create User")
                self.login()
            }
            else{
                print("Error")
              
            }
            
        })*/
    }
    
 /*   func login(){
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion:  {
            user, error in
            
            if error != nil{
                print("Incorrect")
            }
            else{
                print("Currect")
            }
    })
    
    }*/
}
