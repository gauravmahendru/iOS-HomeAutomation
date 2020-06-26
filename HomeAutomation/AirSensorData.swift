//  Created by Lakshank Patel, Neel Shridharani, Gaurav Mahendru
//

import Foundation

class AirSensorData{
    
    var co: Double
    var lpg: Double
    var smoke: Double
    var timeStamp: Double
    
    var dictionary: [String: Any] {
        return ["co": co, "lpg": lpg, "smoke": smoke, "timeStamp": timeStamp]
    }
    
    init(co: Double, lpg: Double, smoke: Double, timeStamp: Double) {
        self.co = co
        self.lpg = lpg
        self.smoke = smoke
        self.timeStamp = timeStamp
    }
}
