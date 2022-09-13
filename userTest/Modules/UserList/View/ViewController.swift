//
//  ViewController.swift
//  userTest
//
//  Created by Yazmin Carmona on 11/09/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var viewModel: UserViewModel = UserViewModel()
    private var  selectedUser: Int64 = -1
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let CELL_NAME = "UserTableViewCell"
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            let alert = UIAlertController.alertActivityIndicator(message: "Por favor espera un momento", title: "Obteniendo usuarios")
            self.present(alert, animated: true)
        }
        viewModel.retriveDataList()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        tableView.register(UINib(nibName: CELL_NAME, bundle: Bundle.main), forCellReuseIdentifier: CELL_NAME)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = .clear
        subcribe()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard  let cell = tableView.dequeueReusableCell(withIdentifier: CELL_NAME, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }

        let user = self.viewModel.userList[indexPath.row]
        cell.bind(model: user) {
            self.showPosts(userId: user.id)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func showPosts(userId: Int64)  {
        self.selectedUser = userId
        self.performSegue(withIdentifier: "ShowPostView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowPostView") {
            let postView = segue.destination as! PostViewController
            postView.userId = selectedUser
        }
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.getFilterList(searchText: searchText)
    }
}

extension ViewController {
    func subcribe() {
        self.viewModel.isDataFiltered.bind { value in
            self.dismiss(animated: true)
            if self.viewModel.userList.count == 0 {
                self.tableView.setEmptyMessage("List is empty")
            } else {
                self.tableView.removeEmptyMessage()
            }
            self.tableView.reloadData()
        }
    }
}
