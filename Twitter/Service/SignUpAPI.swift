//
//  SignUpAPI.swift
//  Twitter
//
//  Created by Rodrigo Vart on 18/08/22.
//

import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

public let DB_REF = Database.database().reference()
public let REF_USERS = DB_REF.child("users")
public let STORAGE_REF = Storage.storage().reference()
public let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

class SignUpAPI {
    var valuesUser = SignUp()
    
    public init(_ valuesUser: SignUp?) {
        if let valuesUser = valuesUser {
            self.valuesUser = valuesUser
        }
    }
    
    func auth(completion: @escaping (String, Bool) -> Void) {
        Auth.auth().createUser(withEmail: valuesUser.email, password: valuesUser.password) { (result, error) in
            if let error = error {
                completion(error.localizedDescription, true)
            } else {
                if let result = result, !result.user.uid.isEmpty {
                    completion(result.user.uid, false)
                }
            }
        }
    }
    
    
    func saveImage() {
        let storageRef = STORAGE_PROFILE_IMAGES.child(valuesUser.image_name)
        
        storageRef.putData(valuesUser.image_data, metadata: nil) { (meta, error) in
            
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
                
                guard let imageUrl = url?.absoluteString else { return }
                self.valuesUser.imageUrl = imageUrl
                print("USER DATA: \(self.valuesUser)")
            }
        }
    }
    
    func saveUser(completion: @escaping (String, Bool) -> Void) {
        REF_USERS.child(valuesUser.uid).updateChildValues(valuesUser.userInfoToSign()) { (error, ref) in
            if let error = error {
                completion(error.localizedDescription, true)
                return
            } else {
                completion(ref.description(), false)
            }
        }
    }
}
