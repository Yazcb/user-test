//
//  UIAlertControllerExtension.swift
//  userTest
//
//  Created by Yazmin Carmona on 12/09/22.
//

import UIKit

extension UIAlertController {
    class func alertActivityIndicator(message:String?, title:String?, handler:((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let spinner = UIActivityIndicatorView.init(style: .medium)

        spinner.startAnimating()
        let customVC = UIViewController.init()
        customVC.view.addSubview(spinner)
        customVC.view.addConstraint(NSLayoutConstraint.init(item: spinner, attribute: .centerX, relatedBy: .equal, toItem: customVC.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        customVC.view.addConstraint(NSLayoutConstraint.init(item: spinner, attribute: .centerY, relatedBy: .equal, toItem: customVC.view, attribute: .centerY, multiplier: 1.0, constant: -10.0))
        alert.setValue(customVC, forKey:"contentViewController")
        
        return alert
    }
}
