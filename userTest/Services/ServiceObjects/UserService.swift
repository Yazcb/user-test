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
    
    func getLocalList(text: String = "", completion: @escaping([User]?) -> Void) {
        DispatchQueue.main.async {
            if text.isEmpty {
                self.getAllUser(completion: completion)
            } else {
                self.getFilteredUser(name: text, completion: completion)
            }
            
        }
    }
    
    private func getFilteredUser(name: String = "", completion: @escaping([User]?) -> Void) {
        DataBaseManager.shared().managedObjectContext.perform {
            let list = (try! DataBaseManager.shared().fetchRequestFrom(entityName: User.name(), predicate: NSPredicate(format: " name contains[c] %@", name))) as? [User]
            completion(list)
        }
    }
    
    private func getAllUser(completion: @escaping([User]?) -> Void) {
        DataBaseManager.shared().managedObjectContext.perform {
            let list = (try! DataBaseManager.shared().fetchRequestFrom(entityName: User.name())) as? [User]
            completion(list)
        }
    }
    
    func processFailWithError(code: Int, error: String) {
        
    }
    
}
