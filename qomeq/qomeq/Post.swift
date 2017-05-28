//
//  Post.swift
//  qomeq
//
//  Created by Arailym Orazkhan on 5/1/17.
//  Copyright © 2017 arailymorazkhan. All rights reserved.
//

import Foundation
import FirebaseDatabase
struct Post {
    var username: String = ""
    var title: String = ""
    var description: String = ""
    var location: String = ""
    var phone: String = ""
    var deadline: String = ""
    
    init(username: String, title: String, description:String, location: String, phone:String, deadline:String) {
        self.username = username
        self.title = title
        self.description = description
        self.location = location
        self.phone = phone
        self.deadline = deadline
    }
    init(snapshot: FIRDataSnapshot) {
        let value = snapshot.value as! NSDictionary
        username = value["username"] as! String
        title = value["title"] as! String
        description = value["description"] as! String
        location = value["location"] as! String
        phone = value["phone"] as! String
        deadline = value["deadline"] as! String
    }
    
    func toAnyObject() -> Any{
        return ["username":username,"title":title,"description":description,"location":location, "phone":phone, "deadline":deadline]
    }
    
}
