//  Created by Lakshank Patel, Neel Shridharani, Gaurav Mahendru


import UIKit

class AirHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var coLabel: UILabel!
    @IBOutlet weak var lpgLabel: UILabel!
    @IBOutlet weak var smokeLabel: UILabel!
    @IBOutlet weak var timeAndDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
