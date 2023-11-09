//
//  Utilities.swift
//  GitInsider
//
//  Created by Alphan Ogün on 8.11.2023.
//

import UIKit

class Utilities {
    
    func inputContainerView(withImage image: UIImage?, textField: UITextField) -> UIView {
        let view = UIView()
        view.setHeight(50)
        
        let iv = UIImageView()
        iv.image = image
        
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(height: 24, width: 24)
        
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        textField.textColor = .white
        
        let divider = UIView()
        divider.backgroundColor = .white
        view.addSubview(divider)
        divider.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        
        return view
    }
    
    func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.white])
        return tf
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart,
                                                        attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributedTitle.append(NSMutableAttributedString(string: " \(secondPart)",
                                                         attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
}

