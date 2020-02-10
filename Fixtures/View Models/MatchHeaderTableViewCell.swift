//
//  ProfileHeaderTableViewCell.swift
//  TheDiveAdvisor
//
//  Created by Ben Smith on 22/05/2018.
//  Copyright © 2018 ben smith. All rights reserved.
//

import UIKit

class MatchHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var championshipLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
