//
//  FeedViewController.swift
//  Twitter
//
//  Created by Rodrigo Vart on 10/08/22.
//

import FirebaseAuth
import SDWebImage
import UIKit

class FeedViewController: UIViewController {
    let viewModel = FeedViewModel()
    
    lazy var imageProfile: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 32, height: 32)
        return imageView
    }()
    
    lazy var imageStars: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "stars")?.tint(.twitterBlue)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 32, height: 32)
        return imageView
    }()
    
    var user: User? {
        didSet {
            if let user = user, let url = user.imageUrl {
                imageProfile.sd_setImage(with: URL(string: url), placeholderImage: UIImage())
                setupLeftImage()
                setupRightImage()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        fetchUserLogged()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    func setupLeftImage() {
        if imageProfile.image != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageProfile)
        }
    }
    
    func setupRightImage() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageStars)
    }
    
    func fetchUserLogged() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        viewModel.fetchUser(uid)
    }
}
