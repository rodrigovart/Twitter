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
    var tweets = Tweet()
    
    func fetchUser(_ uid: String) {
        DATABASE_REFERENCE
            .child(CHILD_USERS_NAME)
            .child(uid)
            .rx
            .observeSingleEvent(.value)
            .subscribe(onSuccess: { [weak self] snapshot in
                guard let self = self else { return }
                self.dictionary = snapshot.value
                self.delegate?.user = self.userAuth()
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.delegate?.showMessage("Error", error.localizedDescription, "", .error)
                self.delegate?.dismissLoader()
            }).disposed(by: disposeBag)
    }
    
    func fechtTweets() {
        print(tweets)
        DATABASE_REFERENCE
            .child(CHILD_TWEET_NAME)
            .child(tweets.uid)
            .rx
            .observeSingleEvent(.childAdded)
            .subscribe(onSuccess: { [weak self] snapshot in
                guard let self = self else { return }
                print(snapshot)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.delegate?.showMessage("Error", error.localizedDescription, "", .error)
                self.delegate?.dismissLoader()
            }).disposed(by: disposeBag)
    }
    
    func userAuth() -> User {
        guard let user = dictionary as? [String: Any] else { return User() }
        
        do {
            userLogged = try User(data: user)
        } catch let error {
            debugPrint(error)
        }
        
        return userLogged
    }
}
