//
//  ServiceManager.swift
//  userTest
//
//  Created by Yazmin Carmona on 11/09/22.
//

import Foundation
import Alamofire

protocol ServiceManagerDelegate {
    func processFailWithError(code: Int, error: String)
}

class ServiceManager {
    
    var delegate: ServiceManagerDelegate?
    var manager: Session
    
    private static var sharedInstance: ServiceManager = {
        let servicedManager = ServiceManager()
        return servicedManager
    }()
    
    //MARK: - Accessors
    class func shared() -> ServiceManager {
        return sharedInstance
    }

    init() {
        let configuration: URLSessionConfiguration = {
            let config = URLSessionConfiguration.default
            return config
        }()
        
        self.manager = Session(configuration: configuration)
    }
    
    func request<T:Codable>(urlService: String, completionHandler: @escaping(T?) -> Void) {
        self.manager.request(urlService).validate().responseDecodable(of: T.self) {
            (response) in
            switch response.result {
            case .success(let data):
                completionHandler(data)
                print(data)
            case .failure(let error):
                self.delegate?.processFailWithError(code: response.response?.statusCode ?? -1, error: error.errorDescription ?? "")
            }
        }
    }
    
    func requestWithParams<T:Codable>(urlService: String, parameters: Parameters, completionHandler: @escaping(T?) -> Void) {
        
        self.manager.request(urlService, parameters: parameters).validate().responseDecodable(of: T.self) {
            (response) in
            switch response.result {
            case .success(let data):
                completionHandler(data)
            case .failure(let error):
                self.delegate?.processFailWithError(code: response.response?.statusCode ?? -1, error: error.errorDescription ?? "")
            }
        }
    }
}
