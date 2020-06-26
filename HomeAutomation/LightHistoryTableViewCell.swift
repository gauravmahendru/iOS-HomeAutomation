//  Created by Lakshank Patel, Neel Shridharani, Gaurav Mahendru
//

import UIKit

class LightHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lightLabel: UILabel!
    @IBOutlet weak var motionLabel: UILabel!
    @IBOutlet weak var ambienceLabel: UILabel!
    @IBOutlet weak var timeAndDateLabel: UILabel!
    @IBOutlet weak var lightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
