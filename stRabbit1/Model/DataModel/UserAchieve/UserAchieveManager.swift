//
//  UserAchieveManager.swift
//  stRabbit1
//
//  Created by gamekf8 on 30/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class UserAchieveManager {
    static let shared = UserAchieveManager()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        
        guard let modelURL = Bundle.main.url(forResource: "UserAchieve", withExtension: "momd") else {
            fatalError("failed to find data")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("failed to laod data")
        }
        
        return model
    }()
    
    private lazy var persistentCoordinate: NSPersistentStoreCoordinator = {
        let pc = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        let fileURL = URL(string: "userAchieve.sqlite", relativeTo: dirURL)
        
        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption: true,
                           NSInferMappingModelAutomaticallyOption: true]
            try pc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: fileURL, options: options)
        } catch {
           fatalError("Fail in config persistent store")
        }
        
        return pc
    }()
    
    private lazy var managedObjectContext: NSManagedObjectContext = {
        
        var mc: NSManagedObjectContext!
        
        if #available(iOS 10.0, *) {
            mc = self.persistentContainer.viewContext
        } else {
            mc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            mc.persistentStoreCoordinator = persistentCoordinate
        }
        
        return mc
    }()
    
    
    @available(iOS 10.0,  *)
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserAchieve")
        container.loadPersistentStores(completionHandler: { (psDescription, error) in
            if let error = error {
                fatalError("error in persistent container")
            }
        })
        return container
    }()
    
    
    func save(){
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                fatalError("error save in core data")
            }
        }
    }
    
    func createEntity() -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: "Achieve", in: self.managedObjectContext)
        let newRecord =  NSManagedObject(entity: entity!, insertInto: self.managedObjectContext)
        return newRecord
    }
}



