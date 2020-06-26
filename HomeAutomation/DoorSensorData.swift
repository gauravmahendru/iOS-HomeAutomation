//  Created by Lakshank Patel,Neel Shridharani, Gaurav Mahendru
//

import Foundation

class DoorSensorData{
    var door: String
    var timeStamp: Double
    
    var dictionary: [String: Any] {
        return ["door": door, "timeStamp": timeStamp]
    }
    
    init(door: String, timeStamp: Double) {
        self.door = door
        self.timeStamp = timeStamp
    }
}
