//
//  BaseService.swift
//  userTest
//
//  Created by Yazmin Carmona on 11/09/22.
//
import Foundation
import Alamofire

protocol BaseServiceObjectDelegate {
    func processFailWithError(code: Int, error: String)
}

class BaseServiceObject: ServiceManagerDelegate {
    enum Server {
        case development, production
    }
   
    internal var serverToUse = Server.development
    let serviceManager = ServiceManager.shared()

    var pathUrlService: String
    var delegate: BaseServiceObjectDelegate?
    
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
        serviceManager.delegate = self
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
    
    func processFailWithError(code: Int, error: String) {
        self.delegate?.processFailWithError(code: code, error: error)
    }
    
    

}
