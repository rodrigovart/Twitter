//
//  SignUpViewController.swift
//  Twitter
//
//  Created by Rodrigo Vart on 11/08/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let viewModel = SignUpViewModel()
    let imagePicker = UIImagePickerController()

    lazy var signUpView: SignUpView = {
        let view = SignUpView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(signUpView)
        signUpView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 30,
            paddingRight: 30
        )
    }
    
    func getValuesForRegister() -> SignUp {
        if let email = signUpView.emailTextField.text, let password = signUpView.passwordTextField.text,
           let name = signUpView.fullNameTextField.text, let user = signUpView.userNameTextField.text, let image = signUpView.imagePhoto.image {
            return SignUp(email: email, password: password, name: name, user: user, image: image)
        }
        
        return SignUp()
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true) {
            let photo = image.withRenderingMode(.alwaysOriginal).resize(CGSize(width: 150, height: 150))
            self.signUpView.imagePhoto.image = photo.withRoundedCorners(image.size.width)
            self.signUpView.layoutIfNeeded()
        }
    }
}

extension SignUpViewController: SignUpDelegate {
    func photoPicker() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func validate() {
        viewModel.valuesUser = getValuesForRegister()
        viewModel.registerUser()
        let controller = MainTabBarController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        return
    }
    
    func login() {
        let controller = LoginViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        return
    }
}


extension SignUpViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
