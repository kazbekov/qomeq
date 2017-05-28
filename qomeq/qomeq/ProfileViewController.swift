//
//  ProfileViewController.swift
//  qomeq
//
//  Created by Arailym Orazkhan on 5/3/17.
//  Copyright © 2017 arailymorazkhan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts = [Post]()
    var dbRef: FIRDatabaseReference?

    @IBOutlet weak var avaImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var name: String = ""
    var surname: String = ""
    var email: String = ""
    var profileImageUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avaImageView.layer.cornerRadius = 62.5
        if FIRAuth.auth()?.currentUser != nil {
            email = (FIRAuth.auth()!.currentUser?.email!)!
        } else {
            print("Nothing")
        }
        title = email
        dbRef = FIRDatabase.database().reference().child("user-object")
        dbRef?.observe(.value, with: { (snapshot:FIRDataSnapshot) in
            for snap in snapshot.children{
                let temp_user = User(snapshot:snap as! FIRDataSnapshot)
                if (self.email == temp_user.email){
                    self.name = temp_user.name
                    self.surname = temp_user.surname
                    
                    self.nameLabel.text = self.name
                    self.surnameLabel.text = self.surname
                    self.emailLabel.text = self.email
                    
                    let url = URL(string: temp_user.profileImageURL)
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        
                        if error != nil {
                            print(error)
                            return
                        }
                        
                        self.avaImageView.image = UIImage(data: data!)
                    }).resume()
                }
            }
        })
        
        
        
        dbRef = FIRDatabase.database().reference().child("post-object")
        dbRef?.observe(.value, with: { (snapshot: FIRDataSnapshot) in
            self.posts.removeAll()
            for snap in snapshot.children{
                let post = Post(snapshot: snap as! FIRDataSnapshot)
                if post.username == self.email{
                    self.posts.append(post)
                }
                
            }
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profilecell") as! ProfilePostTableViewCell
        cell.emailLabel.text = email
        cell.titleLabel.text = posts[indexPath.row].title
        cell.descLabel.text = posts[indexPath.row].description
        cell.locationLabel.text = posts[indexPath.row].location
        cell.phoneLabel.text = posts[indexPath.row].phone
        cell.deadlineLabel.text = posts[indexPath.row].deadline
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 113.0
    }
    
    

}
