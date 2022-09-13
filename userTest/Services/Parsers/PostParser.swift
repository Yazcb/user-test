//
//  PostParser.swift
//  userTest
//
//  Created by Yazmin Carmona on 12/09/22.
//

import Foundation

class PostParser {
    static func parserData(data: [PostModel], completion: @escaping() -> ())  {
        DataBaseManager.shared().managedObjectContext.perform {
            for postModel in data {
                if let post =  Post.object(propertyName: "id", from: postModel.id as NSNumber, in: DataBaseManager.shared().managedObjectContext, createNewObject: true) {
                    post.title = postModel.title
                    post.body = postModel.body
                    post.userId = postModel.userId
                    UserService().getUser(userId: postModel.userId, completion: { user in
                        post.user = user
                    })
                }
            }
            completion()
        }
    }
}
