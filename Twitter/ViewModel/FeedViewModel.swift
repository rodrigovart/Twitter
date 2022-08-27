//
//  FeedViewModel.swift
//  Twitter
//
//  Created by Rodrigo Vart on 27/08/22.
//

import Foundation
import RxSwift

class FeedViewModel {
    let disposeBag = DisposeBag()
    var delegate: FeedViewController?

    func fetchUser(_ uid: String) {
        DATABASE_REFERENCE
            .child(uid)
            .rx
            .observeSingleEvent(.value)
            .subscribe(onSuccess: { [weak self] snapshot in
                guard let self = self else { return }
                debugPrint(snapshot)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.delegate?.showMessage("Error", error.localizedDescription, "", .error)
                self.delegate?.dismissLoader()
            }).disposed(by: disposeBag)
    }
}
