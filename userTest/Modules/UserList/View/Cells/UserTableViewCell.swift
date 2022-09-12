//
//  UserTableViewController.swift
//  userTest
//
//  Created by Yazmin Carmona on 12/09/22.
//

import Foundation
import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    var onButtonTapped: (() -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
    }
    
    
    func initViews()  {
        viewContainer.setCardStyle()
    }
    
    func bind(model: User, completion: @escaping (() -> Void)) {
        self.lblName.text = model.name
        self.lblPhone.text = model.phone
        self.lblEmail.text = model.email
        onButtonTapped = completion
    }
    
    
    @IBAction func showPost(_ sender: Any) {
        if let onButtonTapped = self.onButtonTapped {
            onButtonTapped()
        }
    }
}
