//
//  weather.swift
//  Weatherly
//
//  Created by MIles Work on 2017/04/23.
//  Copyright © 2017 MIles Work. All rights reserved.
//

// MARK: -  To do: Add the Image processing methods.

import Foundation

struct Weather {
  
    let city: String
    let currentDate : String
    let sunrise : String
    let sunset : String
    let tempHigh : String
    let tempLow : String

  
    init(weatherData: JSON) {

        city = weatherData["query"]["results"]["channel"]["location"]["city"].string!
        currentDate = weatherData["query"]["results"]["channel"]["item"]["forecast"][0]["date"].string!
        sunrise = weatherData["query"]["results"]["channel"]["astronomy"]["sunrise"].string!
        sunset = weatherData["query"]["results"]["channel"]["astronomy"]["sunset"].string!
        tempHigh = weatherData["query"]["results"]["channel"]["item"]["forecast"][0]["high"].string!
        tempLow = weatherData["query"]["results"]["channel"]["item"]["forecast"][0]["low"].string!
//        weekForecast = weatherData["query"]["results"]["channel"]["item"]["forecast"].dictionary!

  }
  
}
