//
//  HomeViewController.swift
//  qomeq
//
//  Created by Arailym Orazkhan on 5/1/17.
//  Copyright © 2017 arailymorazkhan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    var dbRef: FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "QomeQ"
        
        dbRef = FIRDatabase.database().reference().child("post-object")
        dbRef?.observe(.value, with: { (snapshot: FIRDataSnapshot) in
            self.posts.removeAll()
            for snap in snapshot.children{
                let post = Post(snapshot: snap as! FIRDataSnapshot)
                self.posts.append(post)
            }
            self.tableView.reloadData()
        })

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PostTableViewCell
        cell.deadlineLabel.text = posts[indexPath.row].deadline
        cell.title.text = posts[indexPath.row].title
        cell.descriptionLabel.text = posts[indexPath.row].description
        cell.phoneNumberLabel.text = posts[indexPath.row].phone
        cell.locationLabel.text = posts[indexPath.row].location
        cell.emailLabel.text = posts[indexPath.row].username
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = NSURL(string: "tel://\(posts[indexPath.row].phone)"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    

}
