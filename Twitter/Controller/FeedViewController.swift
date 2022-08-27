//
//  FeedViewController.swift
//  Twitter
//
//  Created by Rodrigo Vart on 10/08/22.
//

import FirebaseAuth

class FeedViewController: UIViewController {
    let viewModel = FeedViewModel()
    
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
    
    func fetchUserLogged() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        viewModel.fetchUser(uid)
    }
}
