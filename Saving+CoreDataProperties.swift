//
//  Saving+CoreDataProperties.swift
//  ImageInCoreData
//
//  Created by App Designer2 on 10.08.20.
//
//

import Foundation
import CoreData


extension Saving {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Saving> {
        return NSFetchRequest<Saving>(entityName: "Saving")
    }

    @NSManaged public var imageD: Data?
    @NSManaged public var name: String?
    @NSManaged public var detail: String?
    @NSManaged public var rating: Int64
    @NSManaged public var loved: Bool
    @NSManaged public var date : Date?

}
