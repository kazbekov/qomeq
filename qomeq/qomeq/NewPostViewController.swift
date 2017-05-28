//
//  NewPostViewController.swift
//  qomeq
//
//  Created by Arailym Orazkhan on 5/1/17.
//  Copyright © 2017 arailymorazkhan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class NewPostViewController: UIViewController {
    @IBOutlet weak var titleTextFiel: UITextField!

    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var qomeqButton: UIButton!
    @IBOutlet weak var deadlineTextField: UITextField!
    
    var deadline = "27.05"
    var dbRef: FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = FIRDatabase.database().reference().child("post-object")
        qomeqButton.layer.borderWidth = 1
        qomeqButton.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        qomeqButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    @IBAction func qomeqButtonPressed(_ sender: Any) {
        print("kjhgkjh")
        var username:String = ""
        
        if FIRAuth.auth()?.currentUser != nil {
            username = (FIRAuth.auth()!.currentUser?.email!)!
        } else {
            print("Nothing")
        }
        let title = titleTextFiel.text!
        let description = descriptionTextField.text!
        let location = locationTextField.text!
        let phoneNumber = phoneTextField.text!
        
        let date = Date()
        let calendar = Calendar.current
        
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        if deadline == ""{
            deadline = "\(day).\(month)"
        }
        let post = Post(username: username, title: title, description: description, location: location, phone: phoneNumber, deadline: deadline)
        
        let postRef = self.dbRef?.child((title.lowercased()))
        postRef?.setValue(post.toAnyObject())
    }
    
    @IBAction func datepickerpicked(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        deadline = dateFormatter.string(from: (sender as AnyObject).date)
        deadlineTextField.text = deadline
        
    }
    
}
