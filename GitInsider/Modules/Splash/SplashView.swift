//
//  SplashView.swift
//  GitInsider
//
//  Created by Alphan Ogün on 8.01.2024.
//

import UIKit

class SplashView: UIView {
    
    //MARK: - Properties
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(height: 150, width: 150)
        iv.image = UIImage(named: "GitHub_logo")
        return iv
    }()
    
    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "INSIDER"
        label.textColor = .githubLightGray
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [logoImageView, logoLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.alpha = 0
        return stack
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func createSubviews() {
        backgroundColor = .githubBlack
        
        addSubview(stack)
        stack.center(inView: self, yConstant: -40)
    }
    
}
