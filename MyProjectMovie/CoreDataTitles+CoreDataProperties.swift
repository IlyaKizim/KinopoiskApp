//
//  CoreDataTitles+CoreDataProperties.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 14.03.2023.
//
//

import Foundation
import CoreData


extension CoreDataTitles {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataTitles> {
        return NSFetchRequest<CoreDataTitles>(entityName: "CoreDataTitles")
    }

    @NSManaged public var id: Int32
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var overview: String?
    @NSManaged public var voteCount: Int32
    @NSManaged public var releaseDate: String?
    @NSManaged public var voteAverage: Double

}

extension CoreDataTitles : Identifiable {

}
