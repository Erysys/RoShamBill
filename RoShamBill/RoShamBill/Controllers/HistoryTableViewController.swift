//
//  HistoryTableViewController.swift
//  RoShamBill
//
//  Created by Joel on 12/3/19.
//  Copyright © 2019 Joel. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    var history: History!
    var selectedGame: Game?
    var selectedGameNumber: Int?
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        history = History.loadFromFile()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            if history.games.count == 0 {
                return 1
            } else {
                return history.games.count
            }
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(history.games.count == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noHistoryCellIdentifier", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "gameCellIdentifier", for: indexPath)
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            
            cell.textLabel?.text = "Game #\(indexPath.row + 1)"
            cell.detailTextLabel?.text = dateFormatter.string(from: history.games[indexPath.row].datePlayed)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if history.games.count != 0 {
            selectedGame = history.games[indexPath.row]
            selectedGameNumber = indexPath.row + 1
            performSegue(withIdentifier: "historyDetailSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is HistoryDetailTableViewController {
            let historyDetailView = segue.destination as? HistoryDetailTableViewController
            historyDetailView?.game = selectedGame!
            historyDetailView?.gameNumber = selectedGameNumber!
        }
    }
}
