//
//  BaseService.swift
//  userTest
//
//  Created by Yazmin Carmona on 11/09/22.
//
import Foundation
import Alamofire

class BaseServiceObject {
    
    enum Server {
        case development, production
    }
   
    internal var serverToUse = Server.development
    
    var pathUrlService: String

    internal init() {
    #if development
        serverToUse = .development
    #else
        serverToUse = .production
    #endif
        switch serverToUse {
        case .development:
            self.pathUrlService =  "https://jsonplaceholder.typicode.com/"
        case .production:
            self.pathUrlService =  "https://jsonplaceholder.typicode.com/"
        }
    }
    
    enum ServicesUrl: String {
        case users
        case posts

        func getUrl(pathService: String) -> String {
            switch self {
            case .users:
                return pathService.appending("users")
            case .posts:
                return pathService.appending("posts")
            }
        }
    }
}
