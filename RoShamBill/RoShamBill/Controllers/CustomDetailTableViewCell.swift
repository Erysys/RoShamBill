//
//  CustomDetailTableViewCell.swift
//  RoShamBill
//
//  Created by Joel on 12/3/19.
//  Copyright © 2019 Joel. All rights reserved.
//

import UIKit

class CustomDetailTableViewCell: UITableViewCell {

    @IBOutlet var roundLabel: UILabel!
    @IBOutlet var playerLabel: UILabel!
    @IBOutlet var guessLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
