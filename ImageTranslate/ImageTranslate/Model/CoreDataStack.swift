//
//  CoreDataStack.swift
//  ImageTranslate
//
//  Created by Aaron Cleveland on 9/9/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    private init() {}
    
    //create a singleton that is only one instance : you would start with 'CoreDataStack.shared .... '
    static let shared = CoreDataStack()
    
    // creating a computer property of NSPersistentContainer
    // adding lazy, won't create it until I access it. because it's expensive to create in memory.
    lazy var container: NSPersistentContainer = {
        // attaching ourselves to the database.
        let container = NSPersistentContainer(name: "Newstack" as String)
        // loads the data from disc, waking up the data at disc and than access and pull it into memory.
        container.loadPersistentStores() { (_, error) in
            // adding error to see if data comes back an issue
            if let error = error as NSError? {
                // we would change this to a user alert so we can handle it better
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // this is the handle to the data.
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        context.performAndWait {
            do {
                try context.save()
            } catch {
                NSLog("Unable to save context: \(error)")
                context.reset()
            }
        }
    }
}
