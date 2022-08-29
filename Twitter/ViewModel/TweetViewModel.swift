//
//  TweetViewModel.swift
//  Twitter
//
//  Created by Rodrigo Vart on 27/08/22.
//

import RxSwift

class TweetViewModel {
    let disposeBag = DisposeBag()
    var delegate: TweetViewController?
    var error = Error()
    var newTweet = Tweet()
    
    func sendTweet() {
        DATABASE_REFERENCE
            .child(CHILD_TWEET_NAME)
            .child(newTweet.uid)
            .childByAutoId()
            .rx
            .setValue(newTweet.newTweetValues())
            .subscribe(onSuccess: { [weak self] ref in
                guard let self = self else { return }
                self.delegate?.dismissScreen()
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.error(Error(error: true, string: error.localizedDescription))
            }).disposed(by: disposeBag)
    }
    
    private func error(_ error: Error) {
        delegate?.showMessage("Error", error.string, "", .error)
        delegate?.dismissLoader()
    }
}
