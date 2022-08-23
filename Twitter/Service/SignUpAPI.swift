//
//  SignUpAPI.swift
//  Twitter
//
//  Created by Rodrigo Vart on 18/08/22.
//

import FirebaseAuth
import RxSwift

struct Error {
    var error: Bool = false
    var string: String = ""
}

class SignUpAPI {
    let disposeBag = DisposeBag()
    var valuesUser = SignUp()
    var error = Error()
    
    public init(_ valuesUser: SignUp?) {
        if let valuesUser = valuesUser {
            self.valuesUser = valuesUser
        }
    }
    
    private func auth() {
        Auth.auth().createUser(withEmail: self.valuesUser.email, password: self.valuesUser.password) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                self.error = Error(error: true, string: error.localizedDescription)
            } else {
                if let result = result, !result.user.uid.isEmpty {
                    self.valuesUser.uid = result.user.uid
                    print(self.valuesUser.userInfoToSign())
                    DATABASE_USERS_REFERENCE.child(result.user.uid).updateChildValues(self.valuesUser.userInfoToSign())
                }
            }
        }
    }
    
    private func saveImage() {
        let storageRef = STORAGE_PROFILE_IMAGES_REFERENCE.child(self.valuesUser.image_name)
        
        storageRef.putData(self.valuesUser.image_data, metadata: nil) { (meta, error) in
            
            if let error = error {
                self.error = Error(error: true, string: error.localizedDescription)
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    self.error = Error(error: true, string: error.localizedDescription)
                }
                
                guard let imageUrl = url?.absoluteString else { return }
                self.valuesUser.imageUrl = imageUrl
                self.auth()
            }
        }
    }

    func saveUser() -> Observable<Void> {
        saveImage()
        
        return Observable.empty()
    }
}
