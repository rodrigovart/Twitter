//
//  SignUpViewModel.swift
//  Twitter
//
//  Created by Rodrigo Vart on 13/08/22.
//

import UIKit
import FirebaseAuth

class SignUpViewModel {
    var delegate:SignUpViewController?
        
    func registerUser(_ values: SignUp) {
        Auth.auth().createUser(withEmail: values.email, password: values.password) { (result, error) in
            if let error = error {
                self.delegate?.showMessage(error.localizedDescription, "", "", .warning)
                print(error.localizedDescription)
                return
            } else {
                print(result!)
                self.delegate?.login()
            }
        }
    }
}
