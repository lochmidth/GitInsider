//
//  UserCellViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 15.11.2023.
//

import UIKit

class UserCellViewModel {
    
    //MARK: - Properties
    
    var item: Item
    
    var profileImageUrl: URL? {
        URL(string: item.avatarUrl)
    }
    
    var usernameText: String {
        item.login
    }
    
    //MARK: - Lifecycle
    
    init(item: Item) {
        self.item = item
    }
    
    //MARK: - Helpers

    func calculateFontSize(for title: String?, _ cell: UIView) -> CGFloat {
        let maxWidth = cell.frame.width
        let maxFontSize: CGFloat = 16.0
        
        let titleSize = title!.size(withAttributes: [.font: UIFont.boldSystemFont(ofSize: maxFontSize)])
        
        let fontScaleFactor = min(maxWidth / titleSize.width, 1.0)
        let dynamicFontSize = maxFontSize * fontScaleFactor
        
        return min(dynamicFontSize, maxFontSize)
    }
    
}
