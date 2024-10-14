//
//  TimeRangeCheckResultListTableViewCell.swift
//  TimeRangeChecker
//
//  Created by 福原雅隆 on 2024/10/08.
//

import UIKit

class TimeRangeCheckResultListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var startTimeTextLabel: UILabel!
    @IBOutlet weak var endTimeTextLabel: UILabel!
    @IBOutlet weak var targetTimeTextLabel: UILabel!
    @IBOutlet weak var resultTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
