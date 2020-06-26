//  Created by Lakshank Patel, Neel Shridharani, Gaurav Mahendru


import UIKit

class TemperatureHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeAndDateLabel: UILabel!
    @IBOutlet weak var temperatureImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
