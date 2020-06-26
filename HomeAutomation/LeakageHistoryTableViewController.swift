//  Created by Lakshank Patel,Neel Shridharani, Gaurav Mahendru
// This class shows all the water leakage history in the app with a timestamp

import UIKit
import Firebase

class LeakageHistoryTableViewController: UITableViewController {

    var db: Firestore!
    var listLeakageData = [LeakageSensorData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Leakage"
        self.view.backgroundColor = UIColor.systemGray5
        
        listLeakageData.removeAll()
        db = Firestore.firestore()
        loadLeakageData()
        
        
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
        return listLeakageData.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return CGFloat(110)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leakageCell", for: indexPath) as! LeakageHistoryTableViewCell
        
        let data = listLeakageData[indexPath.row]
        
        let date = Date(timeIntervalSince1970: data.timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "h:mm a 'on' MMMM dd, yyyy"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let strDate = dateFormatter.string(from: date)
        
        if(data.leakage == "Yes"){
            cell.leakageLabel.text = "Leakage"
            cell.leakageImageView.image = UIImage(named: "water-leak")
        }else{
            cell.leakageLabel.text = "No leakage"
            cell.leakageImageView.image = UIImage(named: "no-water-leak")
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
    //Displaying all the leak data from the firebase to the app with a timestamp
    func loadLeakageData() {
        
        db.collection("histData").document("leakage").collection("data").getDocuments()
                { (QuerySnapshot, err) in
                    if err != nil{
                        print("Error getting documents: \(String(describing: err))");
                    }else{
                        for document in QuerySnapshot!.documents {
                            if(document.data().count != 0){
                                let data = document.data()
                                let leakage = data["leakage"] as? String
                                let timeStamp = data["timeStamp"] as? Double
                                let dataForList = LeakageSensorData(leakage: leakage!, timeStamp: timeStamp!)

                                self.listLeakageData.append(dataForList)
                            }
                        }
                        self.listLeakageData.sort(by: { $0.timeStamp > $1.timeStamp })
                        self.tableView.reloadData()
                    }
        }
    }
    
}
