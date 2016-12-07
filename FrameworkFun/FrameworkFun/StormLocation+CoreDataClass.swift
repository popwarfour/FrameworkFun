//
//  StormLocation+CoreDataClass.swift
//  FrameworkFun
//
//  Created by Anders Melen on 12/7/16.
//  Copyright © 2016 Anders Melen. All rights reserved.
//

import Foundation
import CoreData
import EVReflection


enum Weather: String {
    case mostlyCloudy = "Mostly Cloudy"
    case sunny = "Sunny"
}

public class StormLocation: NSManagedObject {
    
    var weather: Weather? {
        get {
            
            if let rawWeather = self.rawWeather {
                return Weather(rawValue: rawWeather)
            } else {
                return nil
            }
            
        }
        set {
            self.rawWeather = newValue?.rawValue
        }
    }
    
}

extension StormLocation: EVReflectable {
    
    
    public func propertyMapping() -> [(String?, String?)] {
        
        return [("temp_c",nil),
                ("temperature","temp_f"),
                ("name","state_name")]
        
    }
    
    public func propertyConverters() -> [(String?, ((Any?) -> ())?, (() -> Any?)?)] {
        
        return [
            (
                "weather"
                , {
                    if let stringValue = $0 as? String {
                        self.weather = Weather.init(rawValue: stringValue)
                    }
                    
                }
                , { return self.weather?.rawValue })
        ]
        
    }
}

