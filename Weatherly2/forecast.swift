//
//  weather.swift
//  Weatherly
//
//  Created by MIles Work on 2017/04/23.
//  Copyright © 2017 MIles Work. All rights reserved.
//

// MARK: -  To do: Add the Image processing methods.

import Foundation

struct Forecast {
    
    let date: String
    let tempLow : String
    let tempHigh : String
    

    init(forecastData: JSON) {
        date = forecastData["date"].string!
        tempLow = forecastData["low"].string!
        tempHigh = forecastData["high"].string!
    }
    
}
