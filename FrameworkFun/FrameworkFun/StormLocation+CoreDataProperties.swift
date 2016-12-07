//
//  StormLocation+CoreDataProperties.swift
//  FrameworkFun
//
//  Created by Anders Melen on 12/7/16.
//  Copyright © 2016 Anders Melen. All rights reserved.
//

import Foundation
import CoreData

extension StormLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StormLocation> {
        return NSFetchRequest<StormLocation>(entityName: "Condition");
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var rawWeather: String?
    @NSManaged public var temperature: Double
    @NSManaged public var temp_c: Double

}
