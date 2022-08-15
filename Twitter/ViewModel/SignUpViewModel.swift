//
//  SignUpViewModel.swift
//  Twitter
//
//  Created by Rodrigo Vart on 13/08/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewModel {
    var delegate:SignUpViewController?
    var valuesUser = SignUp()
    
    func registerUser() {
        Auth.auth().createUser(withEmail: valuesUser.email, password: valuesUser.password) { (result, error) in
            if let error = error {
                self.delegate?.showMessage(error.localizedDescription, "", "", .warning)
                print(error.localizedDescription)
                return
            } else {
                if let result = result {
                    print(result)
                    self.valuesUser.uid = result.user.uid
                    self.saveUser()
                }
            }
        }
    }
    
    func saveUser() {
        Database.database().reference().child("users").child(valuesUser.uid).updateChildValues(userInfoToSign()) { (error, ref) in
            if let error = error {
                print(error)
                return
            } else {
                print(ref)
            }
        }
    }
    
    func userInfoToSign() -> [AnyHashable : Any] {
        let keys: [AnyHashable : Any] = ["email": valuesUser.email,
                                         "password": valuesUser.password,
                                         "fullname": valuesUser.name,
                                         "username": valuesUser.user]
        return keys
    }
}
