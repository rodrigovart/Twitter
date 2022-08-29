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
    var tweet = Tweet()
    
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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
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
        
        tableView.register(FeedView.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.addConstraintsToFillView(view)
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
        viewModel.fechtTweets()
    }
}

extension FeedViewController: UITableViewDelegate {}

extension FeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FeedView else { return UITableViewCell() }
        cell.tweet = Tweet()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
