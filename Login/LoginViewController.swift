//
//  LoginViewController.swift
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
class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorTF: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginTapped(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: usernameTextfield.text!, password: passwordTextfield.text!) { [weak self] user, error in
         
            if let firebaseError = error {
                print(firebaseError.localizedDescription)
                self?.errorLabel.text = "Error! "
                self?.errorTF.text = firebaseError.localizedDescription
                self?.errorLabel.textColor = UIColor.red
                self?.errorTF.textColor = UIColor.red
                print("error")
                return
            } else {
                self?.errorLabel.text = "Log in Success"
                self?.errorLabel.textColor = UIColor.green
                 self?.errorTF = nil
                print("Success!")
                
             
                self!.performSegue(withIdentifier: "goHome", sender: self)
            }
        }
        
        
    }
}
