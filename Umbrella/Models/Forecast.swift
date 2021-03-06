//
//  Forecast.swift
//  Umbrella
//
//  Created by Elliott Minns on 06/07/2016.
//  Copyright © 2016 Elliott Minns. All rights reserved.
//

import Foundation
import CoreLocation

struct Forecast {
    
    let location: CLLocation
    
    let placeName: String
    
    var weather: [Weather]
    
    var currentTemperature: Temperature? {
        return weather.first?.temperature
    }
}

extension Forecast: JSONConstructable {
    
    init?(data: [String : AnyObject]) {
        
        guard let city = data["city"] as? [String: AnyObject],
            placeName = city["name"] as? String,
            coordinates = city["coord"] as? [String: Double],
            latitude = coordinates["lat"],
            longtiude = coordinates["lon"],
            weatherData = data["list"] as? [[String: AnyObject]] else {
                return nil
        }
        
        self.placeName = placeName
        
        location = CLLocation(latitude: latitude, longitude: longtiude)
        
        weather = weatherData.map { (data) -> Weather? in
            Weather(data: data)
        }.flatMap { $0 }.sort {
            $0.0.start.timeIntervalSince1970 < $0.1.start.timeIntervalSince1970
        } 
    }
    
}