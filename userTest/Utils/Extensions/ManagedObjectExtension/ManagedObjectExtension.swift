//
//  ManagedObjectExtension.swift
//  userTest
//
//  Created by Yazmin Carmona on 11/09/22.
//

import Foundation
import CoreData


protocol NSManagedObjectExtensionProtocol{
    func listenerImplementationAfterInit()
}


extension NSManagedObject: NSManagedObjectExtensionProtocol {
    func listenerImplementationAfterInit() {
        
    }
    
    
    @objc static func initOnMainContext() -> Self{
        let instance = self.init(entity: DataBaseManager.shared().entityDescription(entityName: name()), insertInto: DataBaseManager.shared().managedObjectContext)
        instance.listenerImplementationAfterInit()
        return instance
    }
    
    static func initInContext(context:NSManagedObjectContext?) -> Self {
        let instance = self.init(entity: DataBaseManager.shared().entityDescription(entityName: name()), insertInto: context)
        instance.listenerImplementationAfterInit()
        return instance
    }
    
    static func name() -> String{
        return NSStringFromClass(self)
    }
    
    
    static func object(propertyName:String,from idObject:NSNumber, in context:NSManagedObjectContext, createNewObject:Bool = false) -> Self? {
        
        func objectHelper<T>(propertyName:String,from idObject:NSNumber, in context:NSManagedObjectContext, createNewObject:Bool = false) -> T? where T : NSManagedObject {
            var object = try! DataBaseManager.shared().objectFrom(predicate: NSPredicate(format: "%K == %@",propertyName,idObject), entityName: self.name(), includeSubentities: false, context: context)
            if object == nil && createNewObject {
                object = self.initInContext(context: context)
                object?.setValue(idObject, forKey: propertyName)
            }
            return object as? T
        }
        
        return objectHelper(propertyName: propertyName, from: idObject, in: context, createNewObject: createNewObject)
    }
}
