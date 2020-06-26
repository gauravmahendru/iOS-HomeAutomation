//  Created by Lakshank Patel,Neel Shridharani, Gaurav Mahendru
// In this class, we are showing it as a main home screen where all the relevant sensor data is been displayed directly from Firebase.
// We have also imported Firebase and FirebaseDatabase libraries to get connected with our firebase(database).

import UIKit
//Importing Firebase commands to connect with our code and fetch all the data
import Firebase
import FirebaseDatabase

class HomeViewController: UIViewController {
    @IBOutlet var backgroundGradientView: UIView!
    
    @IBOutlet weak var imageViewDay: UIImageView!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var currentTimeDate: UILabel!
    @IBOutlet weak var doorViewSeperator: UIView!
    @IBOutlet weak var doorImageView: UIImageView!
    @IBOutlet weak var doorLabel: UILabel!
    @IBOutlet weak var gasViewSeperator: UIView!
    @IBOutlet weak var gasImageView: UIImageView!
    @IBOutlet weak var gasLabel: UILabel!
    @IBOutlet weak var doorStatusLabel: UILabel!
    
    
    
    @IBOutlet weak var waterImageView: UIImageView!
    @IBOutlet weak var coLabel: UILabel!
    @IBOutlet weak var lpgLabel: UILabel!
    @IBOutlet weak var waterHeaderLable: UILabel!
    @IBOutlet weak var waterLeakageLabel: UILabel!
    @IBOutlet weak var smokeLabel: UILabel!
    
    @IBOutlet weak var lightStatus: UILabel!
    @IBOutlet weak var lightsImageView: UIImageView!
    @IBOutlet weak var lightLabel: UILabel!
    @IBOutlet weak var lightsViewSeperator: UIView!
    @IBOutlet weak var waterViewSeperator: UIView!
    @IBOutlet weak var viewSeperator: UIView!
    
    //Variables for connecting with Firebase
    var db = Firestore.firestore()
    var ref = Database.database().reference()
    //Keeping these variables in a Boolean form
    var isDoorAlert = false
    var isLeakageAlert = false
    var isSmokeAlert = false
    var isLightAlert = false
    var isTemperatureAlert = false
    var isCOAlert = false
    var isLPGAlert = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // If the network is unreachable show the offline page
        NetworkManager.isUnreachable { _ in
            self.showOfflinePage()
        }
        
        self.navigationItem.title = "Home"
        self.view.backgroundColor = UIColor.systemGray5
        
        viewSeperator.layer.cornerRadius = 10
        viewSeperator.backgroundColor = UIColor.darkGray
        
        doorViewSeperator.layer.cornerRadius = 10
        doorViewSeperator.backgroundColor = UIColor.darkGray
        
        gasViewSeperator.layer.cornerRadius = 10
        gasViewSeperator.backgroundColor = UIColor.darkGray
        
        waterViewSeperator.layer.cornerRadius = 10
        waterViewSeperator.backgroundColor = UIColor.darkGray
        
        lightsViewSeperator.layer.cornerRadius = 10
        lightsViewSeperator.backgroundColor = UIColor.darkGray
        
        currentTimeDate.textColor = UIColor.white
        currentTemperature.textColor = UIColor.white
        gasLabel.textColor = UIColor.white
        doorLabel.textColor = UIColor.white
        waterHeaderLable.textColor = UIColor.white
        waterLeakageLabel.textColor = UIColor.white
        lightLabel.textColor = UIColor.white
        lightStatus.textColor = UIColor.white
        coLabel.textColor = UIColor.white
        lpgLabel.textColor = UIColor.white
        smokeLabel.textColor = UIColor.white
        
        imageViewDay.image = UIImage(named: "temp")
        doorImageView.image = UIImage(named: "door")
        gasImageView.image = UIImage(named: "smoke-air")
        waterImageView.image = UIImage(named: "water-leak")
        lightsImageView.image = UIImage(named: "light")
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let strDate = dateFormatter.string(from: date)
        self.currentTimeDate.text = strDate
        
        self.loadAirData()
        self.loadDoorData()
        self.loadTempData()
        self.loadWaterData()
        self.loadLightsData()
        
    }

    //This will show an offline pagew if there is no internet connection found
    private func showOfflinePage() -> Void {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "NetworkUnavailable", sender: self)
        }
    }
    //Checking the light output data with Bool condition
    private func loadLightsData() -> Void {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: "lightStatus") == nil {
            lightData()
        } else {
            let lightStatus = preferences.bool(forKey: "lightStatus")
            
            if(lightStatus){
                lightData()
            }else{
                self.lightStatus.text = "Sensor turned off!"
            }
        }
    }
    //Checking the Door output data with Bool condition
    private func loadDoorData() -> Void {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: "doorStatus") == nil {
            doorData()
        } else {
            let doorStatus = preferences.bool(forKey: "doorStatus")
            
            if(doorStatus){
                doorData()
            }else{
                self.doorStatusLabel.text = "Sensor turned off!"
            }
        }
    }
    //Checking the Water output data with Bool condition
    private func loadWaterData() -> Void {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: "waterStatus") == nil {
            leakData()
        } else {
            let waterStatus = preferences.bool(forKey: "waterStatus")
            
            if(waterStatus){
                leakData()
            }else{
                self.waterLeakageLabel.text = "Sensor turned off!"
            }
        }
    }
    //Checking the temperature output data with Bool condition
    private func loadTempData() -> Void {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: "tempStatus") == nil {
            tempData()
        } else {
            let tempStatus = preferences.bool(forKey: "tempStatus")
            
            if(tempStatus){
                tempData()
            }else{
                self.currentTemperature.text = "Sensor turned off!"
            }
        }
    }
    //Checking the Air/Smoke/LPG/CO output data with Bool condition
    private func loadAirData() -> Void{
        let preferences = UserDefaults.standard
        if preferences.object(forKey: "airStatus") == nil {
            airData()
        } else {
            let airStatus = preferences.bool(forKey: "airStatus")
            
            if(airStatus){

                airData()
                
            }else{

                self.smokeLabel.text = "Sensor "
                self.lpgLabel.text = "turned "
                self.coLabel.text = "off!"
                
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadAirData()
        self.loadDoorData()
        self.loadTempData()
        self.loadWaterData()
        self.loadLightsData()
    }
    
    
    //It will load all the data of Air/Smoke/LPG/CO Sensor from Firebase
    private func airData() -> Void {
        db.collection("sensorData").document("airData").addSnapshotListener { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
            
                    if(document.data() != nil){
                        let data = document.data()
                                                
                        var co = data!["co"] as? Double
                        co = Double(round(1000*co!)/1000)
                        
                        var lpg = data!["lpg"] as? Double
                        lpg = Double(round(1000*lpg!)/1000)
                        
                        var smoke = data!["smoke"] as? Double
                        smoke = Double(round(1000*smoke!)/1000)
                        
                        
                        self.smokeLabel.text = String(smoke!)
                        self.coLabel.text = String(co!)
                        self.lpgLabel.text = String(lpg!)
                        
                        if(Double(smoke!) > 2){
                            if(!self.isSmokeAlert){
                                self.showAlert(alertTitle: "The smoke level is rising!", alertMessage: "Please check if there is fire!")
                                self.isSmokeAlert = true
                            }
                        }
                        
                        if(Double(co!) > 1){
                            if(!self.isCOAlert){
                                self.showAlert(alertTitle: "The CO level is rising!", alertMessage: "This is harmful to your health!")
                                self.isCOAlert = true
                            }
                        }
                        
                        if(Double(lpg!) > 1){
                            if(!self.isLPGAlert){
                                self.showAlert(alertTitle: "The LPG level is rising!", alertMessage: "There might be a gas leakage!")
                                self.isLPGAlert = true
                            }
                        }
                        
                    }else{
                                self.smokeLabel.text = "No "
                                self.lpgLabel.text = "data "
                                self.coLabel.text = "available!"
                    }
        }
    }
    //It will load all the Water Leakage data from Firebase
    private func leakData() -> Void {
        db.collection("sensorData").document("leakageData").addSnapshotListener { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    
                    if(document.data() != nil){
                        let data = document.data()
                                                
                        let leakage = data!["leakage"] as? String
                        
                        if (leakage == "Yes"){
                            
                            if(!self.isLeakageAlert){
                                self.showAlert(alertTitle: "There is a water leakage!", alertMessage: "Please check, the water is running now!")
                                self.isLeakageAlert = true
                            }
                            self.waterLeakageLabel.text = "There is a water leakage!"
                        }else{
                            self.waterLeakageLabel.text = "No leakage"
                        }
                    }else{
                                self.waterLeakageLabel.text = "No data available!"
                    }
        }
    }
    //It will load all the  Temperature data from Firebase
    private func tempData() -> Void {
        db.collection("sensorData").document("altiData").addSnapshotListener { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    
                    if(document.data() != nil){
                        let data = document.data()
                                                
                        var temperature = data!["temperature"] as? Double
                        temperature = Double(round(1000*temperature!)/1000)
                        let celc = " °C"
                        
                        if(Double(temperature!) > 25){
                            if(!self.isTemperatureAlert){
                                self.showAlert(alertTitle: "The temperature is rising now!", alertMessage: "Please stay hydrated!")
                                self.isTemperatureAlert = true
                            }
                        }
                        self.currentTemperature.text = String(format:"%.1f" ,temperature!) + celc
                        
                    }else{
                                self.currentTemperature.text = "No data available!"
                    }
        }
    }
    //It will load all the Light data from Firebase
    private func lightData() -> Void {
        db.collection("sensorData").document("rgbMotionData").addSnapshotListener { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    
                    if(document.data() != nil){
                        let data = document.data()
                                                
                        let motion = data!["motion"] as? String
                        
                        
                        if (motion == "Yes"){
                            
                            if(!self.isLightAlert){
                                self.showAlert(alertTitle: "The light is on now!", alertMessage: "Please check, the light is on now!")
                                self.isLightAlert = true
                            }
                            
                            self.lightStatus.text = "Light is on!"
                        }else{
                            self.lightStatus.text = "Light is off!"
                        }
                    }else{
                        self.lightStatus.text = "No data available!"
            }
        }
    }
    //It will load all the Door data from Firebase
    private func doorData() -> Void {
        db.collection("sensorData").document("doorData").addSnapshotListener { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    
                    if(document.data() != nil){
                        let data = document.data()
                                                
                        let door = data!["door"] as? String
                                                
                        if (door == "open "){
                            if(!self.isDoorAlert){
                                self.showAlert(alertTitle: "The door is open!", alertMessage: "Please check, the door is open now!")
                                self.isDoorAlert = true
                           }
                            self.doorStatusLabel.text = "The door is open!"
                        }else{
                            self.doorStatusLabel.text = "The door is closed!"
                        }
                        
                    }else{
                            self.doorStatusLabel.text = "No data available!"
                    }
        }
    }
    //This method will show an alert/popout in the middle of the screen
    private func showAlert(alertTitle: String, alertMessage: String) -> Void {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("")

            case .cancel:
                print("")

            case .destructive:
                print("")
                
            @unknown default: break
                // Error
            }}))
        self.present(alert, animated: true, completion: nil)
    }
}
