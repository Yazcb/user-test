//
//  UserParser.swift
//  userTest
//
//  Created by Yazmin Carmona on 11/09/22.
//

import Foundation

class UserParser {
    static func parserData(data: [UserModel], completion: @escaping() -> ())  {
        DataBaseManager.shared().managedObjectContext.perform {
            for userModel in data {
                if let user =  User.object(propertyName: "id", from: userModel.id as NSNumber, in: DataBaseManager.shared().managedObjectContext, createNewObject: true) {
                    user.name = userModel.name
                    user.userName = userModel.username
                    user.email = userModel.email
                    user.website = userModel.website
                    user.phone = userModel.phone
                    DataBaseManager.shared().saveContext()
                }
            }
            completion()
        }
    }
}
