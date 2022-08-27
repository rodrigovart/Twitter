//
//  LoginViewController.swift
//  Twitter
//
//  Created by Rodrigo Vart on 11/08/22.
//

import FirebaseAuth

class LoginViewController: UIViewController {
    
    let viewModel = LoginViewModel()
    
    lazy var loginView: LoginView = {
        let view = LoginView()
        view.delegate = self
        view.mock()
        return view
    }()
    
    var isValidLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
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
            showLoader()
            viewModel.login(with: loginView.emailTextField.text!, password: loginView.passwordTextField.text!)
        } else {
            showMessage("Preencha todos os campos!", "", "🤔", .warning)
        }
    }
    
    func signUp() {
        showLoader()
        showSignUp()
    }
}
