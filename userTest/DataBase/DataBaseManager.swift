//
//  DataBaseManager.swift
//  userTest
//
//  Created by Yazmin Carmona on 11/09/22.
//

import Foundation
import UIKit
import CoreData

class DataBaseManager {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedObjectContext:NSManagedObjectContext
   
    private static var sharedInstance: DataBaseManager = {
        let dataBaseManager = DataBaseManager()
        return dataBaseManager
    }()
    
    // MARK: - Accessors
    class func shared() -> DataBaseManager {
        return sharedInstance
    }
    
    private init() {
        managedObjectContext = appDelegate.persistentContainer.viewContext
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
        managedObjectContext.automaticallyMergesChangesFromParent = true
    }
    
    func privateObjectContext() ->NSManagedObjectContext {
        let privateContext = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = managedObjectContext
        privateContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        privateContext.automaticallyMergesChangesFromParent = true
        return privateContext
    }
    
    func saveContext() {
        saveContextWith(completionHandler:nil)
    }
    
    func saveContextWith(completionHandler: ((_ success: Bool, _ error: Error?) -> Void)?) {
        saveContext(context: managedObjectContext, completionHandler: completionHandler)
    }
    
    func entityDescription(entityName:String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)!
    }

    func entityDescription(entityName:String, context:NSManagedObjectContext) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
    
    func fetchRequestFrom(entityName:String, context:NSManagedObjectContext) throws ->[Any] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)
        fetchRequest.includesSubentities = false
        let fetchObjects = try context.fetch(fetchRequest)
        return fetchObjects
    }
    
    func fetchRequestFrom(entityName:String) throws ->[Any] {
        return try fetchRequestFrom(entityName: entityName, context: managedObjectContext)
    }
    
    func fetchRequestFrom(entityName:String, predicate:NSPredicate) throws ->[Any] {
        return try fetchRequestFrom(entityName: entityName, predicate: predicate, context: managedObjectContext)
    }
    
    func fetchRequestFrom(entityName:String, predicate:NSPredicate, context:NSManagedObjectContext) throws ->[Any] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)
        fetchRequest.includesSubentities = false
        fetchRequest.predicate = predicate
        return try context.fetch(fetchRequest)
    }
    
    func fetchRequestFrom(entityName:String, context:NSManagedObjectContext, propertyName:String) throws ->[Any] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)
        let entity = entityDescription(entityName: entityName, context: context)
        fetchRequest.resultType = .dictionaryResultType
        let property = [entity.propertiesByName[propertyName]]
        fetchRequest.propertiesToFetch = property as [Any]
        fetchRequest.returnsDistinctResults = true
        let dictionaries = try context.fetch(fetchRequest)
        return dictionaries
    }
    
    func objectFrom(fetchRequest:NSFetchRequest<NSFetchRequestResult>) throws -> NSManagedObject? {
        return try objectFrom(fetchRequest: fetchRequest, context: managedObjectContext)
    }
    
    func objectFrom(fetchRequest:NSFetchRequest<NSFetchRequestResult>, context:NSManagedObjectContext) throws -> NSManagedObject? {
        let data = try context.fetch(fetchRequest)
        if data.count > 0 {
            return data.last as? NSManagedObject
        }
        return nil
    }
    
    func objectFrom(predicate:NSPredicate, entityName:String) throws -> NSManagedObject? {
        return try objectFrom(predicate: predicate, entityName: entityName, includeSubentities: true, context: managedObjectContext)
    }
    
    func objectFrom(predicate:NSPredicate, entityName:String, context:NSManagedObjectContext) throws -> NSManagedObject? {
        return try objectFrom(predicate: predicate, entityName: entityName, includeSubentities: true, context: context)
    }
    
    func objectFrom(predicate:NSPredicate, entityName:String, includeSubentities:Bool) throws -> NSManagedObject? {
        return try objectFrom(predicate: predicate, entityName: entityName, includeSubentities: includeSubentities, context: managedObjectContext)
    }
    
    func objectFrom(predicate:NSPredicate, entityName:String, includeSubentities:Bool, context:NSManagedObjectContext) throws -> NSManagedObject? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)
        fetchRequest.predicate = predicate
        fetchRequest.includesSubentities = includeSubentities
        return try objectFrom(fetchRequest: fetchRequest, context: context)
    }
    
    func deleteObject(_ object:NSManagedObject, fromContext context:NSManagedObjectContext, completionHandler: ((_ success: Bool, _ error: Error?) -> Void)? = nil) {
        context.delete(object)
        if context == managedObjectContext {
            self.saveContextWith(completionHandler: completionHandler)
        } else {
            saveContext(context: context) { (success, error) in
                self.saveContextWith(completionHandler: completionHandler)
            }
        }
        
    }
    
    func deleteAllObjectsFrom(entityName:String) throws {
        try deleteAllObjectsFrom(entityName: entityName, context: managedObjectContext, completionHandler: nil)
    }
    
    func deleteAllDataBase() {
        guard let firstStoreURL = appDelegate.persistentContainer.persistentStoreCoordinator.persistentStores.first?.url else {
               fatalError("Missing first store URL - could not destroy")
           }

           do {
               try appDelegate.persistentContainer.persistentStoreCoordinator.destroyPersistentStore(at: firstStoreURL, ofType: NSSQLiteStoreType, options: nil)
            appDelegate.persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
                       
                       if let error = error as NSError? {
                           fatalError("Unresolved error \(error), \(error.userInfo)")
                       }
                   })
           } catch  {
               fatalError("Unable to destroy persistent store: \(error) - \(error.localizedDescription)")
          }
    }
    
    func deleteAllObjectsFrom(entityName:String, context:NSManagedObjectContext) throws {
        try deleteAllObjectsFrom(entityName: entityName, context: context, completionHandler: nil)
    }
    
    func deleteAllObjectsFrom(entityName:String, context:NSManagedObjectContext, completionHandler: ((_ success: Bool, _ error: Error?) -> Void)?) throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(deleteRequest)
        context.reset()
        saveContext(context: context, completionHandler: completionHandler)
    }
    
    func deleteEntity(entity:NSManagedObject) {
        managedObjectContext.delete(entity)
        saveContext()
    }
    
    func saveContext(context:NSManagedObjectContext, completionHandler: ((_ success: Bool, _ error: Error?) -> Void)?) {
        context.performAndWait {
            do {
                try context.save()
                if completionHandler != nil {
                    completionHandler!(true, nil)
                }
            } catch {
                if completionHandler != nil {
                    completionHandler!(false, nil)
                }
            }
        }
    }
    
    func deleteAllDataBase(completion: @escaping () -> Void) {
        deleteAllDataBase()
        completion()
    }
    
}
