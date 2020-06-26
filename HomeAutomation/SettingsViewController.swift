//  Created by Lakshank Patel, Neel Shridharani, Gaurav Mahendru
//  This is class is used for displaying Settings of an application
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var backgroundGradientView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Settings"
        
        self.view.backgroundColor = UIColor.systemGray5

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
