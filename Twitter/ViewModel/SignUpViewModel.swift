//
//  SignUpViewModel.swift
//  Twitter
//
//  Created by Rodrigo Vart on 13/08/22.
//

import RxSwift
import SwiftMessages

class SignUpViewModel {
    var delegate:SignUpViewController?
    var valuesUser = SignUp()
    var userAPI = SignUpAPI(nil)
    
    func bindUserData(_ data: SignUp) -> Observable<Void> {
        userAPI = SignUpAPI(data)
        valuesUser = data
        return Observable.empty()
    }
    
    func registerUser() {
        userAPI.saveUser().subscribe { [weak self] str in
            guard let self = self else { return }
            print(str)
        } onError: { [weak self] error in
            guard let self = self else { return }
            print(error)
        }
//        userAPI.auth() { [weak self] (str, error) in
//            guard let self = self else { return }
//            if !error {
//                self.valuesUser.uid = str
//                self.saveUser()
//            } else {
//                self.delegate?.showMessage(str, "", "", .warning)
//            }
//        }
    }
}
