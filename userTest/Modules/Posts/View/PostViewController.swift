//
//  PostViewController.swift
//  userTest
//
//  Created by Yazmin Carmona on 12/09/22.
//

import Foundation
import UIKit

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    private var viewModel: PostViewModel = PostViewModel()
    var userId: Int64 = -1
    
    let CELL_NAME = "PostTableViewCell"
    
    
    // MARK: Lify cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: CELL_NAME, bundle: Bundle.main), forCellReuseIdentifier: CELL_NAME)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        subcribe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.setCurrentUserId(userId)
    }
    
    
    // MARK: Table functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.user?.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: CELL_NAME, for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        cell.bind(model: self.viewModel.postList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Publicaciones"
    }
    
}


extension PostViewController {
    func subcribe() {
        self.viewModel.isReponseData.bind { isResponse in
            self.tableView.reloadData()
            self.lblName.text = self.viewModel.user?.name
            self.lblPhone.text = self.viewModel.user?.phone
            self.lblEmail.text = self.viewModel.user?.email
            
            if self.viewModel.postList.count == 0 {
                self.tableView.setEmptyMessage("List is empty")
            } else {
                self.tableView.removeEmptyMessage()
            }
        }
    }
}
