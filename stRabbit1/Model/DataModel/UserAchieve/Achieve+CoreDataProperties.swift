//
//  Achieve+CoreDataProperties.swift
//  
//
//  Created by gamekf8 on 31/01/2018.
//
//

import Foundation
import CoreData


extension Achieve {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Achieve> {
        return NSFetchRequest<Achieve>(entityName: "Achieve")
    }

    @NSManaged public var levelNum: Int16
    @NSManaged public var scoreNum: Int16
    @NSManaged public var usedTime: Float

}
