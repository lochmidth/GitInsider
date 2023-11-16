//
//  SplasController.swift
//  GitInsider
//
//  Created by Alphan Ogün on 14.11.2023.
//

import UIKit

class SplashController: UIViewController {
    //MARK: - Properties
    
    var viewModel: SplashViewModel?
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(height: 150, width: 150)
        iv.image = UIImage(named: "GitHub_logo")
        return iv
    }()
    
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "INSIDER"
        label.textColor = .githubLightGray
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [logoImageView, logoLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.alpha = 0
        return stack
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animateLogoAndCheckAuth()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .githubBlack
        
        view.addSubview(stack)
        stack.center(inView: view, yConstant: -40)
    }
    
    private func animateLogoAndCheckAuth() {
        UIView.animate(withDuration: 3.0) {
            self.stack.alpha = 1
        } completion: { _ in
            self.viewModel?.checkForAuth()
        }

    }
}
