//
//  ViewController.swift
//  qomeq
//
//  Created by Arailym Orazkhan on 4/30/17.
//  Copyright © 2017 arailymorazkhan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signInButton(_ sender: Any) {
        print("signin activated")
        let email = emailTextField.text!
        let password = passwordTextField.text!
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user:FIRUser?,
            error:Error?) in
            if error == nil{
                self.performSegue(withIdentifier: "mySegue", sender: nil)
            }else{
                print("Something happened")
            }
        })
    }
    @IBOutlet weak var signInOutlet: UIButton!
    
    @IBAction func signUpButton(_ sender: Any) {
        
    }
    @IBOutlet weak var signUpOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBorder()
        
        
    }
    
    func setUpBorder(){
        signInOutlet.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        signUpOutlet.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        signInOutlet.layer.borderWidth = 1
        signUpOutlet.layer.borderWidth = 1
        signInOutlet.layer.cornerRadius = 10
        signUpOutlet.layer.cornerRadius = 10
    }

}

