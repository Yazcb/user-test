//
//  UserService.swift
//  userTest
//
//  Created by Yazmin Carmona on 11/09/22.
//

import Foundation


class UserService: BaseServiceObject, ServiceManagerDelegate {

    let serviceManager = ServiceManager.shared()
    
    override init() {
        super.init()
        serviceManager.delegate = self
    }
    
    
    func downloadList(completion: @escaping() -> Void) {
        self.getListFromManager { data in
            if let data = data {
                UserParser.parserData(data: data) {
                   completion()
                }
            }
        }
    }
    
    private func getListFromManager(completion: @escaping([UserModel]?) -> Void) {
        let url = ServicesUrl.users.getUrl(pathService: pathUrlService)
        serviceManager.request(urlService: url, completionHandler: completion)
    }
    
    
    func processFailWithError(code: Int, error: String) {
        
    }
    
}
