//  Created by Lakshank Patel, Neel Shridharani, Gaurav Mahendru
//

import Foundation

class RGBandMotionSensorData{
    var red: Double
    var green: Double
    var blue: Double
    var timeStamp: Double
    var motion: String
    
    var dictionary: [String: Any] {
        return ["red": red, "green": green, "blue": blue, "motion": motion, "timeStamp": timeStamp]
    }
    
    init(red: Double, green: Double, blue: Double, motion: String, timeStamp: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.timeStamp = timeStamp
        self.motion = motion
    }
}
