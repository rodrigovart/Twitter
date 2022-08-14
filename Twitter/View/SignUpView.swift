//
//  SignUpView.swift
//  Twitter
//
//  Created by Rodrigo Vart on 12/08/22.
//

import SkyFloatingLabelTextField

protocol SignUpDelegate: AnyObject {
    func photoPicker()
    func validate()
    func login()
}

class SignUpView: UIView {
    
    var delegate: SignUpViewController?
    
    lazy var imagePhoto: UIImageView = {
        let imagePhoto = UIImageView()
        imagePhoto.translatesAutoresizingMaskIntoConstraints = false
        imagePhoto.isUserInteractionEnabled = true
        imagePhoto.image = UIImage(named: "plus_photo")?.tint(.white)!
        imagePhoto.contentMode = .scaleAspectFit
        imagePhoto.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapButtonPhoto))
        imagePhoto.addGestureRecognizer(tapGestureRecognizer)
        return imagePhoto
    }()
    
    lazy var emailTextField: SkyFloatingLabelTextFieldWithIcon = {
        let textField = SkyFloatingLabelTextFieldWithIcon()
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
    
    lazy var fullNameTextField: SkyFloatingLabelTextFieldWithIcon = {
        let textField = SkyFloatingLabelTextFieldWithIcon()
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.iconType = .image
        textField.placeholder = "Enter your Full Name"
        textField.placeholderColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.iconImage = UIImage(named: "ic_person_outline_white_2x")!
        textField.textColor = .white
        textField.tintColor = .white
        textField.selectedTitleColor = .white
        textField.selectedLineColor = .white
        textField.disabledColor = .white
        textField.updateColors()
        return textField
    }()
    
    lazy var userNameTextField: SkyFloatingLabelTextFieldWithIcon = {
        let textField = SkyFloatingLabelTextFieldWithIcon()
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.iconType = .image
        textField.placeholder = "Enter your Username"
        textField.placeholderColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.iconImage = UIImage(named: "ic_person_outline_white_2x")!
        textField.textColor = .white
        textField.tintColor = .white
        textField.selectedTitleColor = .white
        textField.selectedLineColor = .white
        textField.disabledColor = .white
        textField.updateColors()
        return textField
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .twitterBlue
        button.backgroundColor = .white
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.anchor(height: 50)
        button.addTarget(self, action: #selector(validateTextField), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    lazy var haveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .twitterBlue
        button.attributedString("Already have an account? ", "Log In")
        button.anchor(height: 50)
        button.addTarget(self, action: #selector(tapLoginLabel), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let stackViewPhoto = UIStackView()
        stackViewPhoto.addArrangedSubview(imagePhoto)
        addSubview(stackViewPhoto)
        
        stackViewPhoto.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingBottom: 100
        )
        
        let stackViewTextFields = UIStackView()
        stackViewTextFields.addArrangedSubview(emailTextField)
        stackViewTextFields.addArrangedSubview(passwordTextField)
        stackViewTextFields.addArrangedSubview(fullNameTextField)
        stackViewTextFields.addArrangedSubview(userNameTextField)
        stackViewTextFields.addArrangedSubview(signUpButton)
        stackViewTextFields.axis = .vertical
        stackViewTextFields.spacing = 10
        stackViewTextFields.distribution = .fillEqually
        addSubview(stackViewTextFields)
        
        stackViewTextFields.anchor(
            top: stackViewPhoto.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor
        )
        
        let stackViewLogIn = UIStackView()
        stackViewLogIn.addArrangedSubview(haveAccountButton)
        stackViewLogIn.distribution = .fillEqually
        addSubview(stackViewLogIn)
        
        stackViewLogIn.anchor(
            left: leftAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            right: rightAnchor
        )
    }
    
    @objc func validateTextField() {
        delegate?.validate()
    }
    
    @objc func tapLoginLabel() {
        delegate?.login()
    }
    
    @objc func tapButtonPhoto() {
        delegate?.photoPicker()
    }
}


extension SignUpView {
    @objc func textFieldDidChange(_ textField: UITextField) {
        signUpButton.isEnabled = false
        
        if let email = emailTextField.text, email.isEmpty {
            return
        }
        
        if let password = passwordTextField.text, password.isEmpty {
            return
        }
        
        if let fullName = fullNameTextField.text, fullName.isEmpty {
            return
        }
        
        if let userName = userNameTextField.text, userName.isEmpty {
            return
        }
        
        signUpButton.isEnabled = true
    }
}
