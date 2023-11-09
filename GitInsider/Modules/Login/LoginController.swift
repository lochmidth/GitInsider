//
//  LoginController.swift
//  GitInsider
//
//  Created by Alphan Ogün on 8.11.2023.
//

import UIKit

class LoginController: UIViewController {
    //MARK: - Properties
    
    var viewModel: LoginViewModel! {
        didSet {
            configureViewModel()
        }
    }
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "GitHub_logo")
        return iv
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var emailContainerText = Utilities().inputContainerView(withImage: UIImage(named: "email"), textField: emailTextField)
    private lazy var passwordContainerText = Utilities().inputContainerView(withImage: UIImage(named: "password"), textField: passwordTextField)
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setHeight(50)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account?", "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservers()
    }
    
    //MARK: - Actions
    
    @objc func handleLogin() {
        print("DEBUG: Handle Login")
    }
    
    @objc func handleShowSignUp() {
        viewModel.goToSignUp()
    }
    
    @objc func textDidChange(sender: UITextField) {
//        guard let viewModel else { return }
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        
        configureViewModel()
    }
    
    //MARK: - Helpers
    
    func configureViewModel() {
//        guard let viewModel else { return }
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
    
    private func configureUI() {
        view.backgroundColor = .githubBlack
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(height: 150, width: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerText, passwordContainerText, loginButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                     paddingLeft: 40, paddingRight: 40)
    }
    
    private func configureNotificationObservers() {
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

