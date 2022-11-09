//
//  FeedService.swift
//  Twitter
//
//  Created by Rodrigo Vart on 08/11/22.
//

import RxSwift
import RxCocoa
import SwiftyJSON

class FeedService {
    static let shared = FeedService()
    private let disposeBag = DisposeBag()
    
    private var dictionary:Any?
    
    func rx_FetchUser(_ uid: String, completion: @escaping (User) -> Void) {
        DATABASE_REFERENCE
            .child(CHILD_USERS_NAME)
            .child(uid)
            .rx
            .observeEvent(.value)
            .subscribe(onNext: {[weak self] snapshot in
                guard let self = self else { return }
                self.parseUserLogged(data: snapshot.value ?? []) { user in
                    completion(user)
                }
            }).disposed(by: disposeBag)
    }
    
    private func parseUserLogged(data: Any, completion: @escaping (User) -> Void) {
        do {
            let dict = JSON(data)
            let user = User(data: dict)
            completion(user)
        } catch let error {
            debugPrint(error)
        }
    }
    
    func rx_FechtTweets(_ uid: String, completion: @escaping ([Tweet]) -> Void) {
        DATABASE_REFERENCE
            .child(CHILD_TWEET_NAME)
            .child(uid)
            .rx
            .observeEvent(.childAdded)
            .subscribe(onNext: { [weak self] snapshot in
                guard let self = self else { return }
                self.parseTweets(data: snapshot.value ?? []) { tweets in
                    completion(tweets)
                }
            }).disposed(by: disposeBag)
    }
    
    private func parseTweets(data: Any, completion: @escaping ([Tweet]) -> Void) {
        do {
            let dict = JSON(data)
            let tweet = [Tweet(data: dict)]
            completion(tweet)
        } catch let error {
            debugPrint(error)
        }
    }
}
