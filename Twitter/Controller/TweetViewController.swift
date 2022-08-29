//
//  TweetViewController.swift
//  Twitter
//
//  Created by Rodrigo Vart on 27/08/22.
//

import UIKit

class TweetViewController: UIViewController {
    let viewModel = TweetViewModel()
    let defaults = UserDefaults.standard
    
    lazy var leftButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "x")?.tint(.twitterBlue)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 18, height: 18)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissScreen))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        return imageView
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Tweet", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .twitterBlue
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.anchor(width: 70, height: 35)
        button.layer.cornerRadius = 32 / 2
        button.addTarget(self, action: #selector(tweet), for: .touchUpInside)
        return button
    }()
    
    lazy var tweetView: TweetView = {
        let view = TweetView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        setupUI()
    }
    
    func setupUI() {
        if let url = defaults.string(forKey: "image_url") {
            tweetView.url_image = url
        }
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        
        let leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        navigationItem.setLeftBarButton(leftBarButtonItem, animated: true)
        
        let rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
        
        view.addSubview(tweetView)
        tweetView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
    }
    
    @objc func tweet() {
        guard let uid = defaults.string(forKey: "uid"), let content = tweetView.tweetTextView.text else { return }
        let tweet = Tweet(uid: uid, time: Int(Date.now.timeIntervalSince1970), likes: 0, retweets: 0, content: content)
        viewModel.newTweet = tweet
        viewModel.sendTweet()
    }

    @objc func dismissScreen() {
        dismiss(animated: true, completion: nil)
    }
}
