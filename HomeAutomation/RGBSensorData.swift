//
//  RGBSensorData.swift
//  HomeAutomation
//
//  Created by Lakshank Patel on 9/11/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Foundation

class RGBSensorData{
    var red: Double
    var green: Double
    var blue: Double
    var timeStamp: Double
    
    var dictionary: [String: Any] {
        return ["red": red, "green": green, "blue": blue, "timeStamp": timeStamp]
    }
    
    init(red: Double, green: Double, blue: Double, timeStamp: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.timeStamp = timeStamp
    }
}
