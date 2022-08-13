//
//  SignUpViewController.swift
//  Twitter
//
//  Created by Rodrigo Vart on 11/08/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    var isValidSignUp = false
    
    lazy var signUpView: SignUpView = {
        let view = SignUpView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        if isValidSignUp {
            let controller = MainTabBarController()
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
            return
        }
        
        showMessage("Preencha todos os campos!", "", "🤔", .warning)
    }
    
    func login() {
        let controller = LoginViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        return
    }
}
