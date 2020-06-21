//
//  WinnerViewController.swift
//  RoShamBill
//
//  Created by Joel on 12/3/19.
//  Copyright © 2019 Joel. All rights reserved.
//

import UIKit

class WinnerViewController: UIViewController {

    var game: Game!
    
    @IBOutlet var winningPlayerLabel: UILabel!
    @IBOutlet var winningRoundsLabel: UILabel!
    @IBOutlet var winningGuessLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winningPlayerLabel.text = "\(game.rules.players[game.currentPlayerIndex]) Wins!"
        winningRoundsLabel.text = "After \(game.rounds.count) rounds"
        winningGuessLabel.text = "With a guess of \(game.rules.targetNumber)"

    }
}
