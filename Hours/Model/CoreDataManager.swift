//
//  CoreDataManager.swift
//  Hours
//
//  Created by Roman Samborskyi on 16.08.2023.
//

import Foundation
import CoreData


class CoreDataManager {
    
    static var instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    let containerName: String = "HoursContainer"
    let monthEntityName: String = "MonthEntity"
    let hoursEntityName: String = "HoursEntity"
    
    init() {
        
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { descriprion, error in
            if let error = error {
                print("Error of loading CoreData: \(error)")
            } else {
                print("SUCCSESS")
            }
        }
        context = container.viewContext
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error of saving data: \(error)")
        }
    }
}
