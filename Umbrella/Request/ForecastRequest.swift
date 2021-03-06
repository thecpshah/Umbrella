//
//  ForecastRequest.swift
//  Umbrella
//
//  Created by Elliott Minns on 06/07/2016.
//  Copyright © 2016 Elliott Minns. All rights reserved.
//

import Foundation
import CoreLocation

struct ForecastRequest: OpenWeatherRequest, JSONBuildableRequest, SendableRequest, JSONParsing {
    
    typealias JSONType = Forecast
    
    let endpoint: String = "/forecast"
    
    let latitude: Double
    
    let longitude: Double
    
    let count: Int = 7
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}