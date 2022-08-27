//
//  LoginViewModel.swift
//  Twitter
//
//  Created by Rodrigo Vart on 27/08/22.
//

import FirebaseAuth
import RxSwift

class LoginViewModel {
    let disposeBag = DisposeBag()
    var delegate: LoginViewController?
    
    func login(with email: String, password: String) {
        Auth.auth().rx.signIn(withEmail: email, password: password)
            .subscribe(onNext: { [weak self] authResult in
                guard let self = self else { return }
                self.delegate?.showHome()
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.delegate?.showMessage("Error", error.localizedDescription, "", .error)
                self.delegate?.dismissLoader()
            }).disposed(by: disposeBag)
    }
}
