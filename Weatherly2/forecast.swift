//
//  Forecast.swift
//  Weatherly2
//
//  Created by MIles Work on 2017/04/29.
//  Copyright © 2017 MIles Work. All rights reserved.
//

import Cocoa

class Forecast: NSObject {
    var code : String!
    var date : String!
    var day : String!
    var low : String!
    var high : String!
    var text : String!
    
    init(code : String, date : String, day : String, low : String, high : String, text : String) {
        self.code = code
        self.date = date
        self.day = day
        self.low = low
        self.high = high
        self.text = text
    }
}
