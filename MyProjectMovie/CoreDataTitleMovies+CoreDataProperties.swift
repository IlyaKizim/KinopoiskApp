//
//  CoreDataTitleMovies+CoreDataProperties.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 14.03.2023.
//
//

import Foundation
import CoreData


extension CoreDataTitleMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataTitleMovies> {
        return NSFetchRequest<CoreDataTitleMovies>(entityName: "CoreDataTitleMovies")
    }

//    @NSManaged public var results: [Title]?
    @NSManaged public var title: NSSet?

}

// MARK: Generated accessors for title
extension CoreDataTitleMovies {

    @objc(addTitleObject:)
    @NSManaged public func addToTitle(_ value: CoreDataTitles)

    @objc(removeTitleObject:)
    @NSManaged public func removeFromTitle(_ value: CoreDataTitles)

    @objc(addTitle:)
    @NSManaged public func addToTitle(_ values: NSSet)

    @objc(removeTitle:)
    @NSManaged public func removeFromTitle(_ values: NSSet)

}

extension CoreDataTitleMovies : Identifiable {

}
