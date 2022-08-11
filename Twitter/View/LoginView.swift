//
//  LoginView.swift
//  Twitter
//
//  Created by Rodrigo Vart on 11/08/22.
//

import UIKit

class LoginView: UIView {
    lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "TwitterLogo")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.anchor(width: 150, height: 150)
        return image
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setIcon(UIImage(named: "mail")!)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        textField.tintColor = .white
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setIcon(UIImage(named: "ic_lock_outline_white_2x")!)
        textField.attributedPlaceholder = NSAttributedString(
                string: "Senha",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
            )
        textField.tintColor = .white
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .twitterBlue
        button.backgroundColor = .white
        button.setTitle("Log In", for: .normal)
        button.anchor(height: 50)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    func setupView() {
        let stackViewLogo = UIStackView()
        stackViewLogo.addArrangedSubview(logoImageView)
        stackViewLogo.axis = .horizontal
        addSubview(stackViewLogo)
        
        stackViewLogo.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            left: leftAnchor,
            right: rightAnchor
        )
        
        let stackViewTextFields = UIStackView()
        stackViewTextFields.addArrangedSubview(emailTextField)
        stackViewTextFields.addArrangedSubview(passwordTextField)
        stackViewTextFields.addArrangedSubview(loginButton)
        stackViewTextFields.axis = .vertical
        stackViewTextFields.spacing = 10
        stackViewTextFields.distribution = .fillEqually
        addSubview(stackViewTextFields)
        
        stackViewTextFields.anchor(
            top: stackViewLogo.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
