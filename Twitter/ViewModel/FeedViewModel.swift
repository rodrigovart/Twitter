//
//  FeedViewModel.swift
//  Twitter
//
//  Created by Rodrigo Vart on 27/08/22.
//

import UIKit
import RxRelay

class FeedViewModel {
    var tweets: BehaviorRelay<[Tweet]> = BehaviorRelay(value: [Tweet]())
    
    func rx_FetchUser(_ uid: String, completion: @escaping (User) -> Void) {
        FeedService.shared.rx_FetchUser(uid) {[weak self] user in
            guard let self = self else { return }
            completion(user)
        }
    }
    
    func rx_FechtTweets(_ uid: String) {
        FeedService.shared.rx_FechtTweets(uid) {[weak self] tweet in
            guard let self = self else { return }
            self.tweets.accept(tweet)
        }
    }
}
