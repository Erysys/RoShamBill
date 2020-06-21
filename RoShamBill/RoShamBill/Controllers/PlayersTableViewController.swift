//
//  PlayersTableViewController.swift
//  RoShamBill
//
//  Created by Joel on 1/23/20.
//  Copyright © 2020 Joel. All rights reserved.
//

import UIKit

class PlayersTableViewController: UITableViewController {

    var settings: Settings!
    
    @IBOutlet var numOfPlayersInput: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    @IBAction func playersOKButtonPressed(_ sender: Any) {
        let numOfPlayers = numOfPlayersInput.text!
        let intNumOfPlayers = (numOfPlayers as NSString).integerValue
        
        if intNumOfPlayers <= 50 && intNumOfPlayers >= 2 {
            errorLabel.isHidden = true
            performSegue(withIdentifier: "playersToServer", sender: self)
        } else {
            errorLabel.isHidden = false
        }
    }


    // MARK: - Navigation
    
    @IBAction func unwindToNewGame(segue: UIStoryboardSegue) {
        if segue.identifier == "newGameSegue" {
            numOfPlayersInput.text = ""
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ServerTableViewController {
            let serverView = segue.destination as? ServerTableViewController
            serverView?.settings = settings
            serverView?.numOfPlayers = (numOfPlayersInput.text! as NSString).integerValue
        }
    }


}
