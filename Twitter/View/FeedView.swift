//
//  FeedView.swift
//  Twitter
//
//  Created by Rodrigo Vart on 28/08/22.
//

import UIKit

protocol FeedViewDelegate: AnyObject {
    func comment()
    func retweet()
    func like()
    func share()
}

class FeedView: UITableViewCell {
    var delegate: FeedViewController?
    var isLiked = false
    var isRetweeted = false
    
    var buttonTapCallback: () -> () = { }
    
    var tweet: Tweet? {
        didSet {
            if let tweet = tweet {
//                tweetImage.sd_setImage(with: URL(string: tweet.uid), placeholderImage: UIImage(named: tweet.uid))
            }
        }
    }
    
    lazy var tweetImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "palhaco")
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 50, height: 50)
        return imageView
    }()
    
    lazy var tweetName: UILabel = {
        let label = UILabel()
        label.text = "Palhaço"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var tweetUser: UILabel = {
        let label = UILabel()
        label.text = "@palhaco"
        label.textColor = .darkGray
        return label
    }()
    
    lazy var tweetPointSeparator: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "point")?.tint(.darkGray)
        imageView.anchor(width: 20, height: 10)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var tweetTime: UILabel = {
        let label = UILabel()
        label.text = "1m"
        label.textColor = .darkGray
        return label
    }()
    
    lazy var tweetContent: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse non diam id magna dignissim porta. Etiam quis placerat diam, nec varius felis. Mauris in justo nec metus dictum vestibulum"
        label.textColor = .darkGray
        label.numberOfLines = 10
        label.textAlignment = .justified
        return label
    }()
    
    lazy var tweetComment: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(commentTap), for: .touchUpInside)
        button.setImage(UIImage(named: "comment")?.tint(.darkGray), for: .normal)
        button.contentMode = .scaleAspectFit
        button.anchor(width: 15, height: 15)
        return button
    }()
    
    lazy var tweetRetweet: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(retweetTap), for: .touchUpInside)
        button.setImage(UIImage(named: "retweetar")?.tint(.darkGray), for: .normal)
        button.contentMode = .scaleAspectFit
        button.anchor(width: 15, height: 15)
        return button
    }()
    
    lazy var tweetLike: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(likeTap), for: .touchUpInside)
        button.setImage(UIImage(named: "like")?.tint(.darkGray), for: .normal)
        button.contentMode = .scaleAspectFit
        button.anchor(width: 15, height: 15)
        return button
    }()
    
    lazy var tweetShare: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(shareTap), for: .touchUpInside)
        button.setImage(UIImage(named: "share")?.tint(.darkGray), for: .normal)
        button.contentMode = .scaleAspectFit
        button.anchor(width: 15, height: 15)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    func setupUI() {
        if let image = tweetImage.image {
            tweetImage.image = image.withRoundedCorners(image.size.width)
            tweetImage.layer.masksToBounds = true
        }

        let stackViewImage = UIStackView()
        stackViewImage.addArrangedSubview(tweetImage)

        let stackViewUser = UIStackView()
        stackViewUser.addArrangedSubview(tweetName)
        stackViewUser.addArrangedSubview(tweetUser)
        stackViewUser.addArrangedSubview(tweetPointSeparator)
        stackViewUser.addArrangedSubview(tweetTime)
        stackViewUser.addArrangedSubview(UIView())
        
        stackViewUser.distribution = .fill
        stackViewUser.alignment = .center
        stackViewUser.spacing = 5
        stackViewUser.axis = .horizontal
        
        let stackView = UIStackView()
        stackView.addArrangedSubview(stackViewImage)
        stackView.addArrangedSubview(stackViewUser)
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.spacing = 5
        stackView.axis = .horizontal
        
        addSubview(stackView)
        
        stackView.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingRight: 10
        )
    
        let stackViewContent = UIStackView()
        stackViewContent.addArrangedSubview(tweetContent)
        stackViewContent.axis = .vertical
        stackViewContent.distribution = .fillEqually

        addSubview(stackViewContent)

        stackViewContent.anchor(
            top: stackViewUser.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 2,
            paddingLeft: 65,
            paddingBottom: 10,
            paddingRight: 10
        )
        
        let viewComment = UIView()
        viewComment.addSubview(tweetComment)
        tweetComment.anchor(
            top: viewComment.topAnchor,
            left: viewComment.leftAnchor,
            bottom: viewComment.bottomAnchor
        )
        
        let viewRetweet = UIView()
        viewRetweet.addSubview(tweetRetweet)
        tweetRetweet.anchor(
            top: viewRetweet.topAnchor,
            left: viewRetweet.leftAnchor,
            bottom: viewRetweet.bottomAnchor
        )
        
        let viewLike = UIView()
        viewLike.addSubview(tweetLike)
        tweetLike.anchor(
            top: viewLike.topAnchor,
            left: viewLike.leftAnchor,
            bottom: viewLike.bottomAnchor
        )
        
        let viewShare = UIView()
        viewShare.addSubview(tweetShare)
        tweetShare.anchor(
            top: viewShare.topAnchor,
            left: viewShare.leftAnchor,
            bottom: viewShare.bottomAnchor
        )
        
        let stackViewActions = UIStackView()
        stackViewActions.addArrangedSubview(viewComment)
        stackViewActions.addArrangedSubview(viewRetweet)
        stackViewActions.addArrangedSubview(viewLike)
        stackViewActions.addArrangedSubview(viewShare)
        stackViewActions.addArrangedSubview(UIView())
        
        stackViewActions.axis = .horizontal
        stackViewActions.alignment = .leading
        stackViewActions.distribution = .fillEqually

        addSubview(stackViewActions)

        stackViewActions.anchor(
            top: stackViewContent.bottomAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: 10,
            paddingLeft: 65,
            paddingBottom: 10
        )
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeedView {
    @objc func commentTap() {
        buttonTapCallback()
        delegate?.comment()
    }
    
    @objc func retweetTap() {
        delegate?.retweet()
    }
    
    @objc func likeTap() {
        isLiked.toggle()
        
        if isLiked {
            tweetLike.setImage(UIImage(named: "like_filled")?.tint(.systemRed), for: .normal)
        } else {
            tweetLike.setImage(UIImage(named: "like")?.tint(.darkGray), for: .normal)
        }
        
        delegate?.tableView.reloadData()
        delegate?.like()
    }
    
    @objc func shareTap() {
        delegate?.share()
    }
}
