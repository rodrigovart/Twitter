//
//  SignUpViewController.swift
//  Twitter
//
//  Created by Rodrigo Vart on 11/08/22.
//

import RxSwift
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = SignUpViewModel()
    let imagePicker = UIImagePickerController()
    
    lazy var signUpView: SignUpView = {
        let view = SignUpView()
        view.delegate = self
        view.mock()
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
        //            .subscribe (onNext: { [weak self] str in
        //            guard let self = self else { return }
        //            DispatchQueue.main.async {
        //                print("RETURN FUNCTION: \(str)")
        //                print(Auth.auth().currentUser?.email)
        //                print(Auth.auth().currentUser?.displayName)
        //                print("SIGNUP COMPLETED")
        //                self.dismissLoader()
        //            }
        //        }, onError: { [weak self] error in
        //            guard let self = self else { return }
        //            self.showMessage("Error", "", "", .error)
        //            self.dismissLoader()
        //        }).disposed(by: disposeBag)
    }
    
    func goToFeed() {
        if Auth.auth().currentUser != nil {
            let controller = MainTabBarController()
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
            return
        } else {
            login()
        }
    }
    
    func login() {
        let controller = LoginViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true) {
            do {
                try Auth.auth().signOut()
            } catch let error {
                self.showMessage(error.localizedDescription, "", "", .error)
            }
        }
    }
}


extension SignUpViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
