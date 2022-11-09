//
//  UserModel.swift
//  Twitter
//
//  Created by Rodrigo Vart on 13/08/22.
//

import UIKit
import SwiftyJSON
import FirebaseAuth

struct User {
    var uid: String
    var email: String
    var password: String
    var name: String
    var user: String
    var image: UIImage?
    var imageUrl: String?
    let defaults = UserDefaults.standard
    
    var image_name: String {
        return NSUUID().uuidString
    }
    
    var image_data: Data {
        if let image = image {
            return image.jpegData(compressionQuality: 0.3)!
        }
        
        return Data()
    }
    
    init(uid: String = "", email: String = "", password: String = "", name: String = "", user: String = "", image: UIImage? = nil) {
        self.uid = uid
        self.email = email
        self.password = password
        self.name = name
        self.user = user
        self.image = image
        
        userDefaults()
    }
    
    init (data: JSON) {
        self.uid = Auth.auth().currentUser?.uid ?? ""
        self.email = data["email"].stringValue
        self.password = ""
        self.name = data["fullname"].stringValue
        self.user = data["username"].stringValue
        self.imageUrl = data["image_url"].stringValue
        self.image = nil
        
        userDefaults()
    }
    
    func userInfoToSign() -> [String : Any] {
        var keys: [String : Any] = [:]
        
        if let imageUrl = imageUrl {
            keys = ["email": self.email, "password": self.password, "fullname": self.name, "username": self.user, "image_url": imageUrl]
        } else {
            keys = ["email": self.email, "password": self.password, "fullname": self.name, "username": self.user]
        }
        
        return keys
    }
    
    func userAuth() -> User {
        return self
    }
    
    func userDefaults() {
        defaults.set(self.uid, forKey: "uid")
        defaults.set(self.email, forKey: "email")
        defaults.set(self.name, forKey: "fullname")
        defaults.set(self.user, forKey: "username")
        defaults.set(self.imageUrl, forKey: "image_url")
    }
}
