//
//  LoginView.swift
//  GitInsider
//
//  Created by Alphan Ogün on 8.01.2024.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func handleLogin()
    func handleShowSignUp()
}

class LoginView: UIView {
    //MARK: - Properties
    
    weak var delegate: LoginViewDelegate?
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handleLogin() {
        delegate?.handleLogin()
    }
    
    @objc func handleShowSignUp() {
        delegate?.handleShowSignUp()
    }
    
    //MARK: - Helpers
    
    func createSubviews() {
        backgroundColor = .githubBlack
        
        let stack = UIStackView(arrangedSubviews: [logoImageView, loginButton])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        
        addSubview(stack)
        stack.center(inView: self, yConstant: -25)
        
        addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: leftAnchor,bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor,
                                     paddingLeft: 40, paddingRight: 40)
    }
    
}
