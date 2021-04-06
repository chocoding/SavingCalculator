//
//  Calculate+CoreDataProperties.swift
//  
//
//  Created by 이정민 on 2021/04/06.
//
//

import Foundation
import CoreData


extension Calculate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Calculate> {
        return NSFetchRequest<Calculate>(entityName: "Calculate")
    }

    @NSManaged public var calculate: String?
    @NSManaged public var id: Int64
    @NSManaged public var resulted: String?
    @NSManaged public var saveDate: Date?

}
