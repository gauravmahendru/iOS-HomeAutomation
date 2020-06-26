//  Created by Lakshank Patel, Neel Shridharani, Gaurav Mahendru
// This class shows the histort of the Temprature from the Firebase in timeStamp format

import UIKit
import Firebase

class TemperatureHistoryTableViewController: UITableViewController {

    var db: Firestore!
    var listTemperatureData = [AltimeterSensorData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Temperature"
        self.view.backgroundColor = UIColor.systemGray5
        
        listTemperatureData.removeAll()
        db = Firestore.firestore()
        loadTemperatureData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(110)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listTemperatureData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "tempCell", for: indexPath) as! TemperatureHistoryTableViewCell
        
        let data = listTemperatureData[indexPath.row]
        
        let date = Date(timeIntervalSince1970: data.timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "h:mm a 'on' MMMM dd, yyyy"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let strDate = dateFormatter.string(from: date)

        cell.temperatureLabel.text = "\(data.temperature) °C"
        cell.timeAndDateLabel.text = strDate
        
        if(data.temperature > 20){
            cell.temperatureImageView.image = UIImage(named: "temp-hot")
        }else{
            cell.temperatureImageView.image = UIImage(named: "temp-cold")
        }
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //Here we are calling the Temparture data and showing all its history with the timeStamp format
    func loadTemperatureData() {
        
        db.collection("histData").document("alti").collection("data").getDocuments()
                { (QuerySnapshot, err) in
                    if err != nil{
                        print("Error getting documents: \(String(describing: err))");
                    }else{
                        for document in QuerySnapshot!.documents {
                            if(document.data().count != 0){
                                let data = document.data()
                                let pressure = data["pressure"] as? Double
                                let temperature = data["temperature"] as? Double
                                let altitude = data["altitude"] as? Double
                                let timeStamp = data["timeStamp"] as? Double
                            
                                let dataForList = AltimeterSensorData(temperature: temperature!, pressure: pressure!, altitude: altitude!, timeStamp: timeStamp!)
                            
                                self.listTemperatureData.append(dataForList)
                            }
                        }
                        self.listTemperatureData.sort(by: { $0.timeStamp > $1.timeStamp })
                        self.tableView.reloadData()
                    }
        }
    }
}
