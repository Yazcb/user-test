//
//  ViewController.swift
//  userTest
//
//  Created by Yazmin Carmona on 11/09/22.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel: UserViewModel = UserViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.retriveDataList()
        // Do any additional setup after loading the view.
    }


}

