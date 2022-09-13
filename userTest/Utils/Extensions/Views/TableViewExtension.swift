//
//  TableHelperView.swift
//  userTest
//
//  Created by Yazmin Carmona on 12/09/22.
//
import Foundation
import UIKit

let TAG_EMPTY_LABEL = 1
extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.sizeToFit()
        messageLabel.tag = TAG_EMPTY_LABEL
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    
    func removeEmptyMessage() {
        self.backgroundView = UIView(frame: CGRect.zero)
    }
}
