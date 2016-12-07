//
//  WundergroundLocation+CoreDataProperties.swift
//  FrameworkFun
//
//  Created by Anders Melen on 12/6/16.
//  Copyright © 2016 Anders Melen. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension WundergroundLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WundergroundLocation> {
        return NSFetchRequest<WundergroundLocation>(entityName: "WundergroundLocation");
    }

    @NSManaged public var name: String?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
