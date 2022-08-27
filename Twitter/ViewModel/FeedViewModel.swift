//
//  FeedViewModel.swift
//  Twitter
//
//  Created by Rodrigo Vart on 27/08/22.
//

import RxSwift

class FeedViewModel {
    let disposeBag = DisposeBag()
    var delegate: FeedViewController?
    var dictionary: Any?
    var userLogged = User()
    
    func fetchUser(_ uid: String) {
        DATABASE_REFERENCE
            .child(uid)
            .rx
            .observeSingleEvent(.value)
            .subscribe(onSuccess: { [weak self] snapshot in
                guard let self = self else { return }
                self.dictionary = snapshot.value
                self.userAuth()
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.delegate?.showMessage("Error", error.localizedDescription, "", .error)
                self.delegate?.dismissLoader()
            }).disposed(by: disposeBag)
    }
    
    func userAuth() -> User {
        guard let user = dictionary as? [String: Any] else { return User() }
        userLogged = User(data: user)
        return userLogged
    }
}
