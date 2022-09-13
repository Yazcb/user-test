//
//  UserViewModel.swift
//  userTest
//
//  Created by Yazmin Carmona on 11/09/22.
//

import Foundation
import UIKit

class UserViewModel: BaseServiceObjectDelegate {

    lazy var isDataFiltered: LiveData<Bool> = LiveData(false)
    
    var userList: [User] = []
    var userService = UserService()
    
    init() {
        userService.delegate = self
    }

    func retriveDataList() {
        userService.downloadList {
            self.getFilterList()
        }
    }
    
    func getFilterList(searchText: String = "") {
        userService.getLocalList(text: searchText) { list in
            if let list = list {
                self.userList = list
                DispatchQueue.main.async {
                    self.isDataFiltered.value = true
                }
            }
        }
    }
    
    func processFailWithError(code: Int, error: String) {
        print(error.description)
    }
    
    
}
