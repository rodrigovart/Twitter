//
//  LoginView.swift
//  Twitter
//
//  Created by Rodrigo Vart on 11/08/22.
//

import UIKit
import SkyFloatingLabelTextField

protocol LoginDelegate: AnyObject {
    func validate()
    func signUp()
}

class LoginView: UIView {
    var delegate: LoginViewController?
    
    lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "TwitterLogo")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.anchor(width: 200, height: 200)
        return image
    }()
    
    lazy var emailTextField: SkyFloatingLabelTextFieldWithIcon = {
        let textField = SkyFloatingLabelTextFieldWithIcon()
        textField.iconType = .image
        textField.placeholder = "Enter your Email"
        textField.placeholderColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.iconImage = UIImage(named: "ic_mail_outline_white_2x-1")!
        textField.textColor = .white
        textField.tintColor = .white
        textField.selectedTitleColor = .white
        textField.selectedLineColor = .white
        textField.disabledColor = .white
        textField.updateColors()
        return textField
    }()
    
    lazy var passwordTextField: SkyFloatingLabelTextFieldWithIcon = {
        let textField = SkyFloatingLabelTextFieldWithIcon()
        textField.iconType = .image
        textField.placeholder = "Enter your Password"
        textField.placeholderColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.iconImage = UIImage(named: "ic_lock_outline_white_2x")!
        textField.textColor = .white
        textField.tintColor = .white
        textField.selectedTitleColor = .white
        textField.selectedLineColor = .white
        textField.disabledColor = .white
        textField.updateColors()
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .twitterBlue
        button.backgroundColor = .white
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.anchor(height: 50)
        button.addTarget(self, action: #selector(validateTextField), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.attributedString("Don't have an account? ", "Sign Up")
        label.textColor = .white
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapSignUpLabel))
        label.addGestureRecognizer(tap)
        label.sizeToFit()
        return label
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
        
        signUpView.addSubview(signUpLabel)
        
        let stackViewSignUp = UIStackView()
        stackViewSignUp.addArrangedSubview(signUpView)
        stackViewSignUp.distribution = .fillEqually
        addSubview(stackViewSignUp)
        
        stackViewSignUp.anchor(
            left: leftAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            right: rightAnchor
        )
        
        signUpLabel.center(inView: signUpView)
    }
    
    @objc func validateTextField() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            if !email.isEmpty, !password.isEmpty {
                delegate?.isValidLogin = true
            } else {
                delegate?.isValidLogin = false
            }
        }
        
        delegate?.validate()
    }
    
    @objc func tapSignUpLabel() {
        print("view")
        delegate?.signUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
