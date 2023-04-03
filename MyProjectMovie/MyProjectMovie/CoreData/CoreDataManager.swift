//
//  CoreDataManager.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 02.04.2023.
//
import UIKit
import CoreData


class CoreDataManager {
    
    func saveTask(with title: Title, rate: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "RateMovie", in: context) else {return}
        let taskObject = RateMovie(entity: entity, insertInto: context)

        taskObject.id = Int32(title.id)
        taskObject.posterPath = title.posterPath
        taskObject.originalTitle = title.originalTitle
        taskObject.originalLanguage = title.originalLanguage
        taskObject.overview = title.overview
        taskObject.voteAverage = title.voteAverage ?? 0
        taskObject.releaseDate = title.releaseDate
        taskObject.rate = Int32(rate)
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func updateData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<RateMovie> = RateMovie.fetchRequest()
        
        do {
            MyViewControllerTablePackeges.tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteData(indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<RateMovie> = RateMovie.fetchRequest()
        if let tasks = try? context.fetch(fetchRequest) {
            context.delete(tasks[indexPath.row])
        }
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
