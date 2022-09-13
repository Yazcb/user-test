//
//  UserInfoCustomView.swift
//  userTest
//
//  Created by Yazmin Carmona on 12/09/22.
//

import Foundation
import UIKit


class UserInfoCustomView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    func initSubViews() {
        let nib = UINib(nibName: "UserInfoCustomView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(containerView)
    }
    
    func fillData(model: User) {
        self.lblName.text = model.name
        self.lblPhone.text = model.phone
        self.lblEmail.text = model.email
    }
}
