//
//  User.swift
//  qomeq
//
//  Created by Arailym Orazkhan on 5/1/17.
//  Copyright © 2017 arailymorazkhan. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct User {
    var name: String = ""
    var surname: String = ""
    var email: String = ""
    var password: String = ""
    var profileImageURL: String = ""
    
    init(name: String,surname: String,email:String, password: String, profileImageURL: String) {
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.profileImageURL = profileImageURL
    }
    init(snapshot: FIRDataSnapshot) {
        let value = snapshot.value as! NSDictionary
        name = value["name"] as! String
        surname = value["surname"] as! String
        email = value["email"] as! String
        password = value["password"] as! String
        profileImageURL = value["profileImageURL"] as! String
    }
    func toAnyObject() -> Any{
        return ["name":name,"surname":surname,"email":email,"password":password, "profileImageURL": profileImageURL]
    }
    
}
