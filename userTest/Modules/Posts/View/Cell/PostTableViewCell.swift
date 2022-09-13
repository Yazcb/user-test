//
//  PostTableViewCell.swift
//  userTest
//
//  Created by Yazmin Carmona on 12/09/22.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell {
   
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
    }
    
    func initViews()  {
    }
    
    func bind(model: Post?) {
        if let model = model {
            self.lblTitle.text = model.title
            self.lblBody.text = model.body
        }
    }
}
