//
//  SignUpViewController.swift
//  Twitter
//
//  Created by Rodrigo Vart on 11/08/22.
//

import FirebaseAuth
import RxSwift

class SignUpViewController: UIViewController {
    
    let disposeBag = DisposeBag()
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
        showLoader()
        dismiss(animated: true) {
            let photo = image.withRenderingMode(.alwaysOriginal).resize(CGSize(width: 150, height: 150))
            self.signUpView.imagePhoto.image = photo.withRoundedCorners(image.size.width)
            self.signUpView.layoutIfNeeded()
            self.dismissLoader()
        }
    }
}

extension SignUpViewController: SignUpDelegate {
    func login() {
        showLogin()
    }
    
    func photoPicker() {
        showLoader()
        present(imagePicker, animated: true) {
            self.dismissLoader()
        }
    }
    
    func validate() {
        showLoader()
        viewModel.bindUserData(getValuesForRegister())
        viewModel.createUser()
    }
    
    func goToFeed() {
        if Auth.auth().currentUser != nil {
           showHome()
        } else {
            showLogin()
        }
    }
}


extension SignUpViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
