
import UIKit
import CoreData


class CoreDataManagerTwo {
    
    func saveTask(with title: Title) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainerTwo.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "WillSee", in: context) else {return}
        let taskObject = WillSee(entity: entity, insertInto: context)

        taskObject.id = Int32(title.id)
        taskObject.posterPath = title.posterPath
        taskObject.originalTitle = title.originalTitle
        taskObject.originalLanguage = title.originalLanguage
        taskObject.overview = title.overview
        taskObject.voteAverage = title.voteAverage ?? 0
        taskObject.releaseDate = title.releaseDate
    
        MyViewModel.willSee.append(taskObject)
        do {
            try context.save()
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WillSee")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            try context.execute(deleteRequest)
//            try context.save()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
    }
    
    func updateData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainerTwo.viewContext
        let fetchRequest: NSFetchRequest<WillSee> = WillSee.fetchRequest()
        
        do {
            MyViewModel.willSee = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteData(title: Title) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainerTwo.viewContext
        let fetchRequest: NSFetchRequest<WillSee> = WillSee.fetchRequest()
        if let tasks = try? context.fetch(fetchRequest) {
            context.delete(tasks[0])
        }
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
