//
//  PostService.swift
//  userTest
//
//  Created by Yazmin Carmona on 12/09/22.
//
import Foundation
import Alamofire


class PostService: BaseServiceObject {
        
    func downloadList(userId: Int64, completion: @escaping() -> Void) {
        self.getListFromManager(userId: userId) { data in
            if let data = data {
                PostParser.parserData(data: data) {
                    completion()
                }
            }
        }
    }

    private func getListFromManager(userId: Int64, completion: @escaping([PostModel]?) -> Void) {
        let parameters : Parameters = [
            "userId": userId
        ]
        let url = ServicesUrl.posts.getUrl(pathService: pathUrlService)
        serviceManager.requestWithParams(urlService: url, parameters: parameters, completionHandler: completion)
    }
}
