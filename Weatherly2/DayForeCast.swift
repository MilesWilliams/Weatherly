//
//  DayForeCast.swift
//  Weatherly
//
//  Created by MIles Work on 2017/04/28.
//  Copyright © 2017 MIles Work. All rights reserved.
//

import Cocoa


class DayForeCast: NSObject {
    var code : String?
    var date : String?
    var day : String?
    var low : String?
    var high : String?
    var text : String?
    
    required init(json: JSON) {
        self.code = json["code"].string
        self.date = json["date"].string
        self.day = json["day"].string
        self.high = json["high"].string
        self.low = json["low"].string
        self.text = json["text"].string
        
    }

}
