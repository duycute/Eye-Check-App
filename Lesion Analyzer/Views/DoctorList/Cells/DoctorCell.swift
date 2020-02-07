//
//  TableViewCell.swift
//  Lesion Analyzer
//
//  Created by SM on 28/11/2019.
//  Copyright © 2019 Tran Quang Dat. All rights reserved.
//

import UIKit

class DoctorCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
