//
//  HIstoryTableViewCell.swift
//  Lesion Analyzer
//
//  Created by Tran Quang Dat on 5/30/19.
//  Copyright © 2019 Tran Quang Dat. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var skinIv: UIImageView!
    @IBOutlet weak var riskLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
