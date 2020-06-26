//  Created by Lakshank Patel,Neel Shridharani, Gaurav Mahendru
//

import Foundation

class AltimeterSensorData{
    
    var temperature: Double
    var pressure: Double
    var altitude: Double
    var timeStamp: Double
    
    var dictionary: [String: Any] {
        return ["temperature": temperature, "pressure": pressure, "altitude": altitude, "timeStamp": timeStamp]
    }
    
    init(temperature: Double, pressure: Double, altitude: Double, timeStamp: Double) {
        self.temperature = temperature
        self.altitude = altitude
        self.pressure = pressure
        self.timeStamp = timeStamp
    }
}
