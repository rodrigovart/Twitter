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
    
    init(uid: String = "", email: String = "", password: String = "", name: String = "", user: String = "", image: UIImage? = nil) {
        self.uid = uid
        self.email = email
        self.password = password
        self.name = name
        self.user = user
        self.image = image
    }
}
