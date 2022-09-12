//
//  UserViewModel.swift
//  userTest
//
//  Created by Yazmin Carmona on 11/09/22.
//

import Foundation
import UIKit

class UserViewModel {
    
    lazy var isDataFiltered: LiveData<Bool> = LiveData(false)
    var userList: [User] = []
    var userService = UserService()
    

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
}
