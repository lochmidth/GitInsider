//
//  HomeController.swift
//  GitInsider
//
//  Created by Alphan Ogün on 14.11.2023.
//

import UIKit

class HomeController: UIViewController {
    //MARK: - Properties
    
    var viewModel: HomeViewModel? {
        didSet { configureViewModel() }
    }
    
    private lazy var profileImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightGray
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 2
        button.setDimensions(height: 44, width: 44)
        button.layer.cornerRadius = 44 / 2
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapProfileImage), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigationBar()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//
//    }
    
    //MARK: - Actions
    
    @objc func didTapProfileImage() {
        print("DEBUG: Handle show profile here...")
    }
    
    //MARK: - Helpers
    
    private func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
    }
    
    private func configureUI() {
        view.backgroundColor = .githubGrey
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.isHidden = false
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageButton)
    }
}
