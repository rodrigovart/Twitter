//
//  SignUpViewModel.swift
//  Twitter
//
//  Created by Rodrigo Vart on 13/08/22.
//

import RxFirebaseAuthentication
import RxFirebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import RxSwift

struct Error {
    var error: Bool = false
    var string: String = ""
}

class SignUpViewModel {
    var delegate: SignUpViewController?
    var valuesUser = SignUp()
    let disposeBag = DisposeBag()
    var error = Error()
    
    func bindUserData(_ data: SignUp) {
        valuesUser = data
    }
    
    private func saveImage() {
        let reference = STORAGE_REFERENCE
        reference.putData(valuesUser.image_data)
            .subscribe(onNext: { [weak self] metadata in
                guard let self = self else { return }
                self.getURLImage(reference)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.error(Error(error: true, string: error.localizedDescription))
            }).disposed(by: disposeBag)
    }
    
    private func getURLImage(_ reference: Reactive<StorageReference>) {
        reference.downloadURL()
            .subscribe(onNext: { [weak self] url in
                guard let self = self else { return }
                self.valuesUser.imageUrl = url.absoluteString
                self.saveUser()
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.error(Error(error: true, string: error.localizedDescription))
            }).disposed(by: disposeBag)
    }
    
    private func saveUser() {
        DATABASE_REFERENCE.child(valuesUser.uid)
            .rx
            .updateChildValues(valuesUser.userInfoToSign())
            .subscribe(onSuccess: { [weak self] ref in
                guard let self = self else { return }
                self.loginUser()
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.error(Error(error: true, string: error.localizedDescription))
            }).disposed(by: disposeBag)
    }
    
    func createUser() {
        Auth.auth().rx.createUser(withEmail: valuesUser.email, password: valuesUser.password)
            .subscribe(onNext: { [weak self] authResult in
                guard let self = self else { return }
                self.valuesUser.uid = authResult.user.uid
                self.saveImage()
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.error(Error(error: true, string: error.localizedDescription))
            }).disposed(by: disposeBag)
    }
    
    private func error(_ error: Error) {
        delegate?.showMessage("Error", error.string, "", .error)
        delegate?.dismissLoader()
    }
    
    private func loginUser() {
        delegate?.showMessage("Usuário @\(valuesUser.user) criado!", "", "", .success)
        delegate?.dismissLoader()
        DispatchQueue.main.async {
            self.delegate?.goToFeed()
        }
    }
}
