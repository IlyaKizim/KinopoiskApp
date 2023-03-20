//
//  CoreDataManager.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 14.03.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager(modelName: "CoreDataTitles")
    let persistentConteiner: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentConteiner.viewContext
    }
    
    init(modelName: String) {
        persistentConteiner = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentConteiner.loadPersistentStores { (description, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
}
