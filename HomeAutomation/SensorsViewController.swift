//  Created by Lakshank Patel,Neel Shridharani, Gaurav Mahendru
// This class has all the sensor funcrionalities to toggle on/off in the screen.

import UIKit

class SensorsViewController: UIViewController {
    
    @IBOutlet var backgroundGradientView: UIView!
    @IBOutlet weak var tempSwitchOutlet: UISwitch!
    //Switch functionality for Temperature
    @IBAction func temperatureSwitch(_ sender: UISwitch) {
        if tempSwitchOutlet.isOn {
            tempSwitchOutlet.setOn(true, animated:true)
            
            let preferences = UserDefaults.standard
            let tempStatus = true
            preferences.set(tempStatus, forKey: "tempStatus")
            
        } else {
            tempSwitchOutlet.setOn(false, animated:true)
            
            let preferences = UserDefaults.standard
            let tempStatus = false
            preferences.set(tempStatus, forKey: "tempStatus")
            
        }
    }
    //Switch functionality for Water
    @IBAction func waterSwitch(_ sender: UISwitch) {
        if waterSwitchOutlet.isOn {
            waterSwitchOutlet.setOn(true, animated:true)
            
            let preferences = UserDefaults.standard
            let waterStatus = true
            preferences.set(waterStatus, forKey: "waterStatus")
            
        } else {
            waterSwitchOutlet.setOn(false, animated:true)
            
            let preferences = UserDefaults.standard
            let waterStatus = false
            preferences.set(waterStatus, forKey: "waterStatus")
            
        }
    }
    @IBOutlet weak var temperatureViewSeperator: UIView!
    @IBOutlet weak var temperatureImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var airLabel: UILabel!
    @IBOutlet weak var waterSwitchOutlet: UISwitch!
    
    @IBOutlet weak var doorSwitchOutlet: UISwitch!
    //Switch functionality for Door
    @IBAction func doorSwitch(_ sender: UISwitch) {
        if doorSwitchOutlet.isOn {
            doorSwitchOutlet.setOn(true, animated:true)
            
            let preferences = UserDefaults.standard
            let doorStatus = true
            preferences.set(doorStatus, forKey: "doorStatus")
            
        } else {
            doorSwitchOutlet.setOn(false, animated:true)
            
            let preferences = UserDefaults.standard
            let doorStatus = false
            preferences.set(doorStatus, forKey: "doorStatus")
            
        }
    }
    @IBOutlet weak var airSwitchOutlet: UISwitch!
    //Switch functionality for Air/Smoke/LPG/CO
    @IBAction func airSwitch(_ sender: UISwitch) {
        if airSwitchOutlet.isOn {
            airSwitchOutlet.setOn(true, animated:true)
            
            let preferences = UserDefaults.standard
            let airStatus = true
            preferences.set(airStatus, forKey: "airStatus")
            
        } else {
            airSwitchOutlet.setOn(false, animated:true)
            
            let preferences = UserDefaults.standard
            let airStatus = false
            preferences.set(airStatus, forKey: "airStatus")
            
        }
    }
    
    @IBOutlet weak var airViewSeperator: UIView!
    @IBOutlet weak var airImageView: UIImageView!
    
    @IBOutlet weak var waterViewSeperator: UIView!
    @IBOutlet weak var waterImageView: UIImageView!
    @IBOutlet weak var waterLabel: UILabel!
 
    @IBOutlet weak var doorViewSeperator: UIView!
    @IBOutlet weak var doorImageView: UIImageView!
    @IBOutlet weak var doorLabel: UILabel!
    //Switch functionality for Light
    @IBAction func lightsSwitch(_ sender: UISwitch) {
        
        if lightsSwitchOutlet.isOn {
            lightsSwitchOutlet.setOn(true, animated:true)
            let preferences = UserDefaults.standard
            let lightStatus = true
            preferences.set(lightStatus, forKey: "lightStatus")
        } else {
            lightsSwitchOutlet.setOn(false, animated:true)
            let preferences = UserDefaults.standard
            let lightStatus = false
            preferences.set(lightStatus, forKey: "lightStatus")
        }
        
    }
    
    @IBOutlet weak var lightsSwitchOutlet: UISwitch!
    @IBOutlet weak var lightsViewSeperator: UIView!
    @IBOutlet weak var lightsImageView: UIImageView!
    @IBOutlet weak var lightsLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Sensors"
        self.view.backgroundColor = UIColor.systemGray5
        
        let preferences = UserDefaults.standard
        //Looking for Light status
        if preferences.object(forKey: "lightStatus") == nil {
            //  Doesn't exist
        } else {
            let lightStatus = preferences.bool(forKey: "lightStatus")
            
            if(lightStatus){
                lightsSwitchOutlet.setOn(true, animated:false)
            }else{
                lightsSwitchOutlet.setOn(false, animated:false)
            }
        }
        //Looking for Air Status
        if preferences.object(forKey: "airStatus") == nil {
            //  Doesn't exist
        } else {
            let airStatus = preferences.bool(forKey: "airStatus")
            
            if(airStatus){
                airSwitchOutlet.setOn(true, animated:false)
            }else{
                airSwitchOutlet.setOn(false, animated:false)
            }
        }
        //Looking for Water Status
        if preferences.object(forKey: "waterStatus") == nil {
            //  Doesn't exist
        } else {
            let waterStatus = preferences.bool(forKey: "waterStatus")
            
            if(waterStatus){
                waterSwitchOutlet.setOn(true, animated:false)
            }else{
                waterSwitchOutlet.setOn(false, animated:false)
            }
        }
        //Looking for Door Status
        if preferences.object(forKey: "doorStatus") == nil {
            //  Doesn't exist
        } else {
            let doorStatus = preferences.bool(forKey: "doorStatus")
            
            if(doorStatus){
                doorSwitchOutlet.setOn(true, animated:false)
            }else{
                doorSwitchOutlet.setOn(false, animated:false)
            }
        }
        //Looking for Temperature Status
        if preferences.object(forKey: "tempStatus") == nil {
            //  Doesn't exist
        } else {
            let tempStatus = preferences.bool(forKey: "tempStatus")
            
            if(tempStatus){
                tempSwitchOutlet.setOn(true, animated:false)
            }else{
                tempSwitchOutlet.setOn(false, animated:false)
            }
        }
        
        temperatureViewSeperator.layer.cornerRadius = 10
        waterViewSeperator.layer.cornerRadius = 10
        airViewSeperator.layer.cornerRadius = 10
        doorViewSeperator.layer.cornerRadius = 10
        lightsViewSeperator.layer.cornerRadius = 10
        
        tempSwitchOutlet.onTintColor = UIColor.systemOrange
        airSwitchOutlet.onTintColor = UIColor.systemOrange
        doorSwitchOutlet.onTintColor = UIColor.systemOrange
        lightsSwitchOutlet.onTintColor = UIColor.systemOrange
        waterSwitchOutlet.onTintColor = UIColor.systemOrange
        
    }
}
