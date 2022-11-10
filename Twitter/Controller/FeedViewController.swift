//
//  FeedViewController.swift
//  Twitter
//
//  Created by Rodrigo Vart on 10/08/22.
//

import RxSwift
import FirebaseAuth
import SDWebImage

class FeedViewController: UIViewController {
    let viewModel = FeedViewModel()
    let disposeBagUI = DisposeBag()
    
    var user = User()
    var tweet = [Tweet]()
    
    private lazy var imageProfile: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 32, height: 32)
        return imageView
    }()
    
    private lazy var imageStars: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "stars")?.tint(.twitterBlue)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 32, height: 32)
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(FeedView.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserLogged()
        getTweets()
    }
    
    private func getUserLogged() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        viewModel.rx_FetchUser(uid) {[weak self] user in
            guard let self = self else { return }
            self.user = user
            self.setupUI()
        }
    }
    
    private func getTweets() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        viewModel.rx_FechtTweets(uid)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.showTweets()
        }
    }
    
    private func showTweets() {
        viewModel.tweets.subscribe(onNext: { [weak self] tweets in
            guard let self = self else { return }
            tweets.forEach { tweet in
                self.tweet.append(tweet)
                self.tableView.reloadData()
            }
        }, onError: { [weak self] error in
            guard let self = self else { return }
            self.showMessage("Error", error.localizedDescription, "", .error)
        }).disposed(by: disposeBagUI)
    }
    
    private func setupUI() {
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        setupLeftImage()
        setupRightImage()
    }
    
    private func setupLeftImage() {
        guard let image = user.imageUrl else { return }
        imageProfile.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: image))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageProfile)
    }
    
    private func setupRightImage() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageStars)
    }
}

extension FeedViewController: UITableViewDelegate {}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FeedView else { return UITableViewCell() }
        cell.delegate = self
        cell.tag = indexPath.row
        cell.user = user
        cell.tweet = tweet[indexPath.row]
        cell.configCell()
        return cell
    }
}

extension FeedViewController: FeedViewDelegate {
    func comment() {
        print("comment")
    }
    
    func retweet() {
        print("retweet")
    }
    
    func like() {
        print("like")
    }
    
    func share() {
        print("share")
    }
}
