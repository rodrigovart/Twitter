//
//  SignUpModel.swift
//  Twitter
//
//  Created by Rodrigo Vart on 13/08/22.
//

import UIKit

struct SignUp {
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
    
    func userInfoToSign() -> [AnyHashable : Any] {
        var keys: [AnyHashable : Any] = [:]
        
        if let imageUrl = imageUrl {
            keys = ["email": self.email, "password": self.password, "fullname": self.name, "username": self.user, "image_url": imageUrl]
        } else {
            keys = ["email": self.email, "password": self.password, "fullname": self.name, "username": self.user]
        }
        
        return keys
    }
}
