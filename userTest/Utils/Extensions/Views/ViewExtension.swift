//
//  ViewExtension.swift
//  userTest
//
//  Created by Yazmin Carmona on 12/09/22.
//

import UIKit

extension UIView {
    
    func setCardStyle(){
        let color = UIColor(red: 0.92, green: 0.93, blue: 0.96, alpha: 1.00)
         self.layer.cornerRadius = 10
         self.layer.masksToBounds = false
         self.layer.backgroundColor = UIColor.white.cgColor
         self.layer.borderWidth = 1
         self.layer.borderColor = color.cgColor
         self.layer.shadowColor = color.cgColor
         self.layer.shadowOpacity = 0.5
         self.layer.shadowOffset = CGSize.zero
         self.layer.shadowRadius = 5
     }
}
