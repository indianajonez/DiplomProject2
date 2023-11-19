//
//  CoreDataManager.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    //MARK: - Public properties
    
    static let shared = CoreDataManager()
    
    //MARK: - Private properties
    
    private let appDelegate: AppDelegate
    private let managedContext: NSManagedObjectContext
    
    //MARK: - Life cycles
    
    private init() {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedContext = appDelegate.persistentContainer.viewContext
    }
    
    //MARK: - Public methods
    
    func save() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("\(error). Info: \(error.userInfo)")
        }
    }
    
    func delete(_ object: NSManagedObject) {
        managedContext.delete(object)
        try? managedContext.save()
    }
    
    func fetchData(_ request:  NSFetchRequest<NSManagedObject>) -> [NSManagedObject] {
        do {
            let result = try managedContext.fetch(request)
            return result
        } catch let error as NSError {
            print("\(error). Info: \(error.userInfo)")
            return []
        }
    }
    
    func createNewFavorite(_ data: Post) -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: "PostStorage", in: managedContext)!
        let newFavorite = NSManagedObject(entity: entity, insertInto: managedContext)
        newFavorite.setValue(data.author, forKeyPath: "author")
        newFavorite.setValue(data.description, forKeyPath: "desc")
        newFavorite.setValue(data.image, forKeyPath: "image")
        newFavorite.setValue(data.likes, forKeyPath: "likes")
        newFavorite.setValue(data.views, forKeyPath: "views")
        return newFavorite
    }
}



