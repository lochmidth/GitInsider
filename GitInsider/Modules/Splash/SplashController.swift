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
    let splashView = SplashView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        animateLogoAndCheckAuth()
    }
    
    override func loadView() {
        view = splashView
    }
    
    deinit {
        print("DEBUG: \(self) deallocated.")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func animateLogoAndCheckAuth() {
        UIView.animate(withDuration: 3.0) {
            self.splashView.stack.alpha = 1
        } completion: { [weak self] _ in
            self?.viewModel?.checkForAuth()
        }

    }
}
