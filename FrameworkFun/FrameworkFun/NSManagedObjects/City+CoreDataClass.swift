//
//  City+CoreDataClass.swift
//  FrameworkFun
//
//  Created by Anders Melen on 12/8/16.
//  Copyright © 2016 Anders Melen. All rights reserved.
//

import Foundation
import CoreData
import EVReflection
import Alamofire
import CoreStore

//@objc(City)


func autocast<T>(some: Any) -> T? {
    return some as? T
}

protocol DTOReflection {
    static func parseJSON(parameters: Parameters?,
                          transaction: BaseDataTransaction) -> Self?
    static func parseJSON(json: String?,
                          transaction: BaseDataTransaction) -> Self?
    func json() -> Parameters?
    func dto() -> DTO
}


enum Weather: String {
    case mostlyCloudy = "Mostly Cloudy"
    case sunny = "Sunny"
}



public class City: NSManagedObject, DTOReflection {
    
    static let sampleJSON = "{\"display_location\": {  \"state_name\": \"California\"},\"observation_location\": {  \"latitude\": \"37.778488\",  \"longitude\": \"-122.408005\"},\"weather\": \"Mostly Cloudy\",\"temp_f\": 49.6,\"temp_c\": 9.8,\"relative_humidity\": \"54%\"}"
    
    var weather: Weather? {
        set {
            self.rawWeather = newValue?.rawValue
        }
        get {
            var weather: Weather?
            if let rawWeather = self.rawWeather,
                let tempWeather = Weather(rawValue: rawWeather) {
                weather = tempWeather
            }
            return weather
        }
    }
    

// MARK: DTOReflection Protocol
    
    func dto() -> DTO {
        return CityDTO(city: self)
    }
    
    static func parseJSON(parameters: Parameters?,
                          transaction: BaseDataTransaction) -> Self? {
    
        var city: City?
        if let parameters = parameters {
            
            let cityDTO = CityDTO(dictionary: parameters as NSDictionary)
            city = cityDTO.managedObject(transaction: transaction)
        }
        return autocast(some: city)

    }
    
    static func parseJSON(json: String?,
                          transaction: BaseDataTransaction) -> Self? {
        
        var city: City?
        if let json = json {
            let cityDTO = CityDTO(json: json)
            city = cityDTO.managedObject(transaction: transaction)
        }
        return autocast(some: city)
        
    }

    func json() -> Parameters? {
        
        let cityDTO = self.dto()
        let json = cityDTO.toDictionary() as! Parameters

        return json
        
    }
    
    
}

protocol DTOProtocol {
    static func createFromManagedObject(some: NSManagedObject) -> Self?
    func managedObject<T: NSManagedObject>(transaction: BaseDataTransaction) -> T
}
public class DTO: EVObject { }

public class CityDTO: DTO, DTOProtocol {
    
    struct DisplayLocation {
        let state_name: String?
    }
    
    struct ObservationLocation {
        let latitude: Double?
        let longitude: Double?
    }
    
    var displayLocation: DisplayLocation?
    var observerLocation: ObservationLocation?
    var weather: Weather?
    var temperature: Double?

    static func createFromManagedObject(some: NSManagedObject) -> Self? {
        
        var city: City?
        if let tempCity = some as? City {
            
            city = tempCity
            
            city.
            
        }
        
        return autocast(some: city)
        
    }
    
    
//    static func createFromCity(city: City) -> CityDTO {
//        
//        let cityDTO = CityDTO()
//        
//        return
//        
//    }
    
//    init(city: City) {
//    
//        // TODO: Configure here..
//        
//    }
    
    // MARK: - DTOProtocol
    func managedObject<T>(transaction: BaseDataTransaction) -> T {
        

        let city = transaction.create(Into(City.self))

        // TODO: Configure NSManagedObject here...

        return autocast(some: city)!
        
    }
    
    // MARK: - EVObject
    override open func propertyMapping() -> [(String?, String?)] {
        return [("weather","weather"),
                 ("temperature","temp_f"),
                 ("latitude","latitude"),
                 ("longitude","longitude")]
    }
    
    override open func propertyConverters() -> [(String?, ((Any?)->())?, (() -> Any?)? )] {
        return [
            (
                "weather"
                , {
                    if let stringWeather = $0 as? String,
                        let weather = Weather(rawValue: stringWeather) {
                        
                        self.weather = weather
                        
                    }
                }
                , {
                    return self.weather?.rawValue
            })
        ]
    }
    
    
    
}
