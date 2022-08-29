//
//  FeedView.swift
//  Twitter
//
//  Created by Rodrigo Vart on 28/08/22.
//

import UIKit

class FeedView: UITableViewCell {
    var tweet: Tweet? {
        didSet {
            if let tweet = tweet {
//                tweetImage.sd_setImage(with: URL(string: tweet.uid), placeholderImage: UIImage(named: tweet.uid))
            }
        }
    }
    
    lazy var tweetImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "palhaco")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var tweetName: UILabel = {
        let label = UILabel()
        label.text = "Palhaço"
        label.textColor = .darkGray
        return label
    }()
    
    lazy var tweetContent: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse non diam id magna dignissim porta. Etiam quis placerat diam, nec varius felis. Mauris in justo nec metus dictum vestibulum"
        label.textColor = .darkGray
        label.numberOfLines = 10
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = .white
        
        if let image = tweetImage.image {
            tweetImage.image = image.resize(CGSize(width: 100, height: 100)).withRoundedCorners(50)
            tweetImage.layer.masksToBounds = true
        }
        
        let stackView = UIStackView()
        stackView.addArrangedSubview(tweetImage)
        stackView.addArrangedSubview(tweetName)
        stackView.addArrangedSubview(UIView())
        
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 20
        
        let stackViewWithInstructions = UIStackView()
        stackViewWithInstructions.addArrangedSubview(stackView)
        stackViewWithInstructions.addArrangedSubview(tweetContent)
        
        stackViewWithInstructions.axis = .vertical
        stackViewWithInstructions.spacing = 10
        stackViewWithInstructions.distribution = .fillEqually
        
        addSubview(stackViewWithInstructions)
        
        stackViewWithInstructions.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
