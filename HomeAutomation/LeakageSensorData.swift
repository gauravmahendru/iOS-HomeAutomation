//  Created by Lakshank Patel,Neel Shridharani, Gaurav Mahendru
//

import Foundation

class LeakageSensorData{
    var leakage: String
    var timeStamp: Double
    
    var dictionary: [String: Any] {
        return ["leakage": leakage, "timeStamp": timeStamp]
    }
    
    init(leakage: String, timeStamp: Double) {
        self.leakage = leakage
        self.timeStamp = timeStamp
    }
}
