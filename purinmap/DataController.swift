//
//  File.swift
//  purinmap
//
//  Created by 渡辺航太郎 on 2019/05/06.
//  Copyright © 2019 litech. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    
    
    
    
    static let shared: DataManager = DataManager()
    
    private var persistentContainer: NSPersistentContainer!
    
    init() {
        
        persistentContainer = NSPersistentContainer(name: "purinmap")
        persistentContainer.loadPersistentStores { (description, error) in
            
            if let error = error {
                fatalError("Failed to load Core Data Stack: \(error)")
            }
            
            print(description)
        }
    }
    
    func create<T: NSManagedObject>() -> T {
        
        let context = persistentContainer.viewContext
        let object = NSEntityDescription.insertNewObject(forEntityName: String(describing: T.self), into: context) as! T
        
        return object
    }
    
    func saveContext() {
        
        let context = persistentContainer.viewContext
        
        do {
            
            try context.save()
        } catch {
            
            print("Failed save context: \(Error.self)")
        }
    }
    
    func getFetchedResultController<T: NSManagedObject>(with descriptor: [String] = [] ) -> NSFetchedResultsController<T> {
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.sortDescriptors = descriptor.map { NSSortDescriptor(key: $0, ascending: true) }
        
        return NSFetchedResultsController<T>(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }

}
