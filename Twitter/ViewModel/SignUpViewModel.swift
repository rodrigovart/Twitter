//
//  SignUpViewModel.swift
//  Twitter
//
//  Created by Rodrigo Vart on 13/08/22.
//

import UIKit
import SwiftMessages

class SignUpViewModel {
    var delegate:SignUpViewController?
    var valuesUser = SignUp()
    
    func registerUser() {
        UserAPI(valuesUser).auth() { [weak self] (str, error) in
            guard let self = self else { return }
            if !error {
                self.valuesUser.uid = str
                self.saveUser()
            } else {
                self.delegate?.showMessage(str, "", "", .warning)
            }
        }
    }
    
    func saveUser() {
        UserAPI(valuesUser).saveUser() { [weak self] (str, error) in
            guard let self = self else { return }
            if error {
                self.delegate?.showMessage(str, "", "", .warning)
                return
            }
        }
    }
}
