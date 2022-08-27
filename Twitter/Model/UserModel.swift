//
//  UserModel.swift
//  Twitter
//
//  Created by Rodrigo Vart on 13/08/22.
//

import UIKit

struct User {
    var uid: String
    var email: String
    var password: String
    var name: String
    var user: String
    var image: UIImage?
    var imageUrl: String?
    
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
    }
    
    init (data: [String: Any]) throws {
        self.uid = ""
        self.email = try data["email"] as! String
        self.password = ""
        self.name = try data["fullname"] as! String
        self.user = try data["username"] as! String
        self.imageUrl = try data["image_url"] as? String
        self.image = nil
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
}
