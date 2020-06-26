//  Created by Lakshank Patel,Neel Shridharani, Gaurav Mahendru
// This class will show all the historical data of Door sensor in a TimeStamp format


import UIKit
import Firebase

class DoorHistoryTableViewController: UITableViewController {

    var db: Firestore!
    var listDoorData = [DoorSensorData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Door"
        self.view.backgroundColor = UIColor.systemGray5
        
        listDoorData.removeAll()
        db = Firestore.firestore()
        loadDoorData()
        
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
        return listDoorData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return CGFloat(110)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "doorCell", for: indexPath) as! DoorHistoryTableViewCell
        
        let data = listDoorData[indexPath.row]
        //Date Formatter is been called
        let date = Date(timeIntervalSince1970: data.timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "h:mm a 'on' MMMM dd, yyyy"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let strDate = dateFormatter.string(from: date)
        
        if(data.door == "open "){
            cell.doorLabel.text = "Door open"
            cell.doorImageView.image = UIImage(named: "open-door")
        }else{
            cell.doorLabel.text = "Door closed"
            cell.doorImageView.image = UIImage(named: "closed-door")
        }
        
        cell.timeAndDateLabel.text = strDate

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
    //All the histroical data from Door sensor is fetched in a timestamp format
    func loadDoorData() {
        
        db.collection("histData").document("door").collection("data").getDocuments()
                { (QuerySnapshot, err) in
                    if err != nil{
                        print("Error getting documents: \(String(describing: err))");
                    }else{
                        for document in QuerySnapshot!.documents {
                            if(document.data().count != 0){
                                let data = document.data()
                                let door = data["door"] as? String
                                let timeStamp = data["timeStamp"] as? Double
                                let dataForList = DoorSensorData(door: door!, timeStamp: timeStamp!)
                                self.listDoorData.append(dataForList)
                            }
                        }
                        self.listDoorData.sort(by: { $0.timeStamp > $1.timeStamp })
                        self.tableView.reloadData()
                    }
        }
    }
    
}
