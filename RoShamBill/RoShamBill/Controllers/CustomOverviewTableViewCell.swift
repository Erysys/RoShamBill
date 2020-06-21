//
//  CustomOverviewTableViewCell.swift
//  RoShamBill
//
//  Created by Joel on 12/3/19.
//  Copyright © 2019 Joel. All rights reserved.
//

import UIKit

class CustomOverviewTableViewCell: UITableViewCell {

    @IBOutlet var gameNumberLabel: UILabel!
    @IBOutlet var numOfPlayersLabel: UILabel!
    @IBOutlet var numOfRoundsLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var winningNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
