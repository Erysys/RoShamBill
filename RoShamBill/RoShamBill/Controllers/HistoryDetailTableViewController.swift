//
//  HistoryDetailTableViewController.swift
//  RoShamBill
//
//  Created by Joel on 12/3/19.
//  Copyright © 2019 Joel. All rights reserved.
//

import UIKit

class HistoryDetailTableViewController: UITableViewController {
    
    var game: Game!
    var gameNumber: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            return 1
        } else {
            return game.rounds.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailOverviewCellIdentifier", for: indexPath) as! CustomOverviewTableViewCell
            cell.gameNumberLabel.text = "Game #\(gameNumber!)"
            cell.numOfPlayersLabel.text = "\(game.rules.numOfPlayers) Players"
            cell.numOfRoundsLabel.text = "\(game.rounds.count) Rounds"
            cell.winnerLabel.text = "Winner: \(game.rounds.last!.player)"
            cell.winningNumberLabel.text = String(game.rules.targetNumber)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailRoundsCellIdentifier", for: indexPath) as! CustomDetailTableViewCell
            let round = game.rounds[indexPath.row]
            cell.roundLabel.text = "ROUND \(indexPath.row + 1)"
            cell.playerLabel.text = round.player
            cell.guessLabel.text = String(round.guess)
            if round.result == "Higher!" {
                cell.resultLabel.text = "Too Low"
            } else if round.result == "Lower!" {
                cell.resultLabel.text = "Too High"
            } else {
                cell.resultLabel.text = "Winner!"
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 110
        } else if indexPath.section == 1 {
            return 70
        } else {
            return 44
        }
    }
}
