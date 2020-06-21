//
//  ServerTableViewController.swift
//  RoShamBill
//
//  Created by Joel on 1/23/20.
//  Copyright © 2020 Joel. All rights reserved.
//

import UIKit

class ServerTableViewController: UITableViewController {

    var settings: Settings!
    var numOfPlayers: Int!
    var rules: Rules!
    var game: Game!
    
    @IBOutlet var guessNumberInput: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var targetRangeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rules = Rules(minGuessNumber: settings.minNumber, maxGuessNumber: settings.maxNumber, targetNumber: 0, numOfPlayers: numOfPlayers)
        errorLabel.text = "Please enter a number between \(settings.minNumber) and \(settings.maxNumber)"
        targetRangeLabel.text = "\(settings.minNumber) and \(settings.maxNumber)"
        game = Game(rules: rules)
        
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

    @IBAction func serverOKButtonPressed(_ sender: Any) {
        let guessNumber = guessNumberInput.text!
        let intGuessNumber = (guessNumber as NSString).integerValue
        
        
        if intGuessNumber <= settings.maxNumber && intGuessNumber >= settings.minNumber {
            errorLabel.isHidden = true
            performSegue(withIdentifier: "serverToGuess", sender: self)
        } else {
            errorLabel.isHidden = false
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is GameTableViewController {
            let gameView = segue.destination as? GameTableViewController
            self.game.rules.targetNumber = (guessNumberInput.text! as NSString).integerValue
            gameView?.game = game
        }
    }


}
