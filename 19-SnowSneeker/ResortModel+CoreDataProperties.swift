//
//  ResortModel+CoreDataProperties.swift
//  SnowSneeker
//
//  Created by Kaveesh Khattar on 02/07/22.
//
//

import Foundation
import CoreData


extension ResortModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResortModel> {
        return NSFetchRequest<ResortModel>(entityName: "ResortModel")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var country: String?
    @NSManaged public var descriptionResort: String?
    @NSManaged public var price: Int16
    @NSManaged public var size: Int16
    @NSManaged public var elevation: Int16
    @NSManaged public var snowDepth: Int16
    @NSManaged public var runs: Int16
    @NSManaged public var facilities: [String]?
    @NSManaged public var coordinates: [Double]?

}

extension ResortModel : Identifiable {

}
