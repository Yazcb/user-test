//
//  PostViewModel.swift
//  userTest
//
//  Created by Yazmin Carmona on 12/09/22.
//

import Foundation
import UIKit
import SwiftUI

class PostViewModel {

    lazy var isReponseData: LiveData<Bool> = LiveData(false)
    var postService = PostService()
    var userService = UserService()
    var user: User?
    var postList =  [Post]()
    
    init() {
        postService.delegate = self
        userService.delegate = self
    }
    
    func setCurrentUserId(_ id: Int64) {
        userService.getUser(userId: id) { userResponse in
            self.user = userResponse
            if userResponse?.posts?.count ?? 0 > 0 {
                self.setPostList()
                self.isReponseData.value = true
            } else {
                self.getPostByUser(userId: id)
            }
        }
    }
    
    private func getPostByUser(userId: Int64) {
        postService.downloadList(userId: userId) {
            self.setPostList()
            self.isReponseData.value = true
        }
    }
    
    private func setPostList() {
        postList = self.user?.posts?.allObjects as! [Post]
    }
}

extension PostViewModel: BaseServiceObjectDelegate {
    func processFailWithError(code: Int, error: String) {
        print(error.description)
    }
}
