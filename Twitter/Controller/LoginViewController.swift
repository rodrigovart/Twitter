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
        view.delegate = self
        return view
    }()
    
    var isValidLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(loginView)
        loginView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 30,
            paddingRight: 30
        )
    }
}

extension LoginViewController: LoginDelegate {
    func validate() {
        if isValidLogin {
            let controller = MainTabBarController()
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
            return
        }
        
        showMessage("Preencha todos os campos!", "", "🤔", .warning)
    }
    
    func signUp() {
        let controller = SignUpViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        return
    }
    
}
