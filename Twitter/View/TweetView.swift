//
//  TweetView.swift
//  Twitter
//
//  Created by Rodrigo Vart on 27/08/22.
//

import UIKit
import SDWebImage
import KMPlaceholderTextView

class TweetView: UIView {
    var delegate: TweetViewController?
    
    var url_image: String? {
        didSet {
            imageProfile.sd_setImage(with: URL(string: url_image!), placeholderImage: UIImage())
        }
    }
    
    lazy var imageProfile: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 32, height: 32)
        return imageView
    }()
    
    lazy var tweetTextView: KMPlaceholderTextView = {
        let textView = KMPlaceholderTextView()
        textView.delegate = self
        textView.placeholder = "What's happening?"
        textView.placeholderColor = .darkGray
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textAlignment = .justified
        textView.textColor = .darkGray
        textView.backgroundColor = .white
        textView.anchor(height: 300)
        return textView
    }()
    
    lazy var countLettersLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .twitterBlue
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        let viewImage = UIView()
        viewImage.addSubview(imageProfile)
        imageProfile.anchor(
            top: viewImage.topAnchor,
            left: viewImage.leftAnchor,
            bottom: viewImage.bottomAnchor,
            paddingLeft: 10
        )
        
        let viewTweet = UIView()
        viewTweet.addSubview(tweetTextView)
        tweetTextView.anchor(
            top: viewTweet.topAnchor,
            left: viewTweet.leftAnchor,
            bottom: viewTweet.bottomAnchor,
            right: viewTweet.rightAnchor,
            paddingLeft: 42,
            paddingRight: 15
        )
        
        let viewCountLetters = UIView()
        viewCountLetters.addSubview(countLettersLabel)
        countLettersLabel.anchor(
            top: viewCountLetters.topAnchor,
            bottom: viewCountLetters.bottomAnchor,
            right: viewCountLetters.rightAnchor,
            paddingRight: 15
        )
        
        let stackView = UIStackView()
        stackView.addArrangedSubview(viewImage)
        stackView.addArrangedSubview(viewTweet)
        stackView.addArrangedSubview(viewCountLetters)
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            left: leftAnchor,
            bottom: nil,
            right: rightAnchor,
            paddingTop: 20
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TweetView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let str = textView.text else { return }
        let count = 140 - str.count
        countLettersLabel.text = "\(count)"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let str = textView.text else { return false }
        if text.contains(UIPasteboard.general.string ?? "") {
            return false
        }
        return str.count <= 140
    }
}
