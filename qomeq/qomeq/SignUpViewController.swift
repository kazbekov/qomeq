//
//  SignUpViewController.swift
//  qomeq
//
//  Created by Arailym Orazkhan on 5/1/17.
//  Copyright © 2017 arailymorazkhan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var dbRef: FIRDatabaseReference?
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var surnameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    @IBOutlet weak var setAvaImageView: UIImageView!
    
    @IBOutlet weak var signUpOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAvaImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapgesturetapped)))
        setUp()
        dbRef = FIRDatabase.database().reference().child("user-object")

    }
    
    func tapgesturetapped(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            setAvaImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        print("cancel picker")
    }
    
    func setUp(){
        signUpOutlet.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        signUpOutlet.layer.borderWidth = 1
        signUpOutlet.layer.cornerRadius = 10
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        let name = nameLabel.text!
        let surname = surnameLabel.text!
        let email = emailLabel.text!
        let password = passwordLabel.text!
        
        let imageName = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("\(imageName).png")
        
        if let uploadData = UIImagePNGRepresentation(setAvaImageView.image!){
            storageRef.put(uploadData, metadata: nil, completion: {
                (metadata, error) in
                
                if error != nil {
                    print(error ?? "")
                    return
                }
                if let absoluteurl = metadata?.downloadURL()?.absoluteString{
                    let new_user = User(name: name, surname: surname, email: email, password: password, profileImageURL: absoluteurl)
                    if (new_user.name.characters.count == 0 || new_user.surname.characters.count == 0 || new_user.email.characters.count == 0 || new_user.password.characters.count == 0)
                    {
                        print("Empty field")
                        
                    } else{
                        let userRef = self.dbRef?.child((name.lowercased()))
                        
                        userRef?.setValue(new_user.toAnyObject())
                        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                            print ("User added")
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            })
        }
        
        
    }
}

