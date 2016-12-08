//
//  City+CoreDataProperties.swift
//  FrameworkFun
//
//  Created by Anders Melen on 12/8/16.
//  Copyright © 2016 Anders Melen. All rights reserved.
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City");
    }

    @NSManaged public var rawWeather: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var temperature: Double

}
