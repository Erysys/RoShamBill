//
//  GameTableViewController.swift
//  RoShamBill
//
//  Created by Joel on 1/23/20.
//  Copyright © 2020 Joel. All rights reserved.
//

import UIKit

class GameTableViewController: UITableViewController {
    
    var game: Game!
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var playerLabel: UILabel!
    @IBOutlet var guessRangeLabel: UILabel!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var guessNumberInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    func updateViews() {
        playerLabel.text = game.rules.players[game.currentPlayerIndex]
        guessRangeLabel.text = "\(game.rules.minGuessNumber) and \(game.rules.maxGuessNumber)"
        errorLabel.text = "Please enter a number between \(game.rules.minGuessNumber) and \(game.rules.maxGuessNumber)"
    }
    
    @IBAction func OKButtonPressed(_ sender: Any) {
        let guessNumber = guessNumberInput.text!
        let intGuessNumber = (guessNumber as NSString).integerValue
        let currentPlayer = game.rules.players[game.currentPlayerIndex]
        
        if !game.isValidGuess(guess: intGuessNumber) {
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
            let result = game.playerGuess(guess: intGuessNumber)
            let currentRound = Round(player: currentPlayer, guess: intGuessNumber, result: result, index: game.rounds.count)
            resultLabel.text = result
            resultLabel.isHidden = false
            game.rounds.append(currentRound)
            
            if game.isGameFinished {
                History.saveToFile(game: game)
                
                performSegue(withIdentifier: "winnerSegue", sender: nil)
            } else {
                guessNumberInput.text = ""
                game.nextPlayer()
                updateViews()
            }
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is WinnerViewController {
            let winnerView = segue.destination as? WinnerViewController
            winnerView?.game = game
        }
    }


}
