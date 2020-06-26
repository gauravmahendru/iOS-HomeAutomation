//  Created by Lakshank Patel, Neel Shridharani, Gaurav Mahendru

import UIKit

class LeakageHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var leakageLabel: UILabel!
    @IBOutlet weak var timeAndDateLabel: UILabel!
    @IBOutlet weak var leakageImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
