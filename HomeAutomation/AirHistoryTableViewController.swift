//  Created by Lakshank Patel,Neel Shridharani, Gaurav Mahendru
// This will show all the history of Air/Smoke/LPG/CO data in a timeStamp format

import UIKit
import Firebase

class AirHistoryTableViewController: UITableViewController {

    var db: Firestore!
    var listAirData = [AirSensorData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Air"
        self.view.backgroundColor = UIColor.systemGray5
        
        listAirData.removeAll()
        db = Firestore.firestore()
        loadAirData()
        
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listAirData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return CGFloat(130)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "airCell", for: indexPath) as! AirHistoryTableViewCell
        
        let data = listAirData[indexPath.row]
        
        let date = Date(timeIntervalSince1970: data.timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "h:mm a 'on' MMMM dd, yyyy"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let strDate = dateFormatter.string(from: date)
        
        cell.timeAndDateLabel.text = strDate
        cell.coLabel.text = "CO: \(data.co)"
        cell.lpgLabel.text = "LPG: \(data.lpg)"
        cell.smokeLabel.text = "Smoke: \(data.smoke)"
        
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
    //Loading all the data from Histdata for Air/SMOKE/LPG/Co in timeStamp format
    func loadAirData() {
        
        db.collection("histData").document("air").collection("data").getDocuments()
                { (QuerySnapshot, err) in
                    if err != nil{
                        print("Error getting documents: \(String(describing: err))");
                    }else{
                        for document in QuerySnapshot!.documents {
                            if(document.data().count != 0){
                                let data = document.data()
                                var co = data["co"] as? Double
                                var lpg = data["lpg"] as? Double
                                var smoke = data["smoke"] as? Double
                                let timeStamp = data["timeStamp"] as? Double
                                
                                co = Double(round(1000*co!)/1000)
                                lpg = Double(round(1000*lpg!)/1000)
                                smoke = Double(round(1000*smoke!)/1000)
                            
                                let dataForList = AirSensorData(co: co!, lpg: lpg!, smoke: smoke!, timeStamp: timeStamp!)
                            
                                self.listAirData.append(dataForList)
                            }
                        }
                        self.listAirData.sort(by: { $0.timeStamp > $1.timeStamp })
                        self.tableView.reloadData()
                    }
        }
    }
    
}
