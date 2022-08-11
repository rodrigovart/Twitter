//
//  LoginViewController.swift
//  Twitter
//
//  Created by Rodrigo Vart on 11/08/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var loginView: LoginView = {
        let view = LoginView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(loginView)
        loginView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 30,
            paddingRight: 30
        )
    }
}
