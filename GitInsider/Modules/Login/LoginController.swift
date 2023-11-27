//
//  LoginController.swift
//  GitInsider
//
//  Created by Alphan Ogün on 8.11.2023.
//

import UIKit

class LoginController: UIViewController {
    //MARK: - Properties
    
    var viewModel: LoginViewModel?
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(height: 150, width: 150)
        iv.image = UIImage(named: "GitHub_logo")
        return iv
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in with GitHub", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setDimensions(height: 50, width: 150)
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
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar()
    }
    
    deinit {
        print("DEBUG: \(self) deallocated.")
    }
    
    //MARK: - Actions
    
    @objc func handleLogin() {
        viewModel?.goToLogin()
    }
    
    @objc func handleShowSignUp() {
        viewModel?.goToSignUp()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .githubBlack
        
        let stack = UIStackView(arrangedSubviews: [logoImageView, loginButton])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.center(inView: view, yConstant: -25)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                     paddingLeft: 40, paddingRight: 40)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
}

