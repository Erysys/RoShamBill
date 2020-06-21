//
//  ViewController.swift
//  RoShamBill
//
//  Created by Joel on 11/6/19.
//  Copyright © 2019 Joel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var settings: Settings!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings = Settings.loadFromFile()
    }

    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        if segue.identifier == "saveButtonSegue" {
            settings = Settings.loadFromFile()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playersSegue" {
            let playersView = segue.destination as? PlayersTableViewController
            playersView?.settings = settings
        } else if segue.identifier == "settingsSegue" {
            if let navController = segue.destination as? UINavigationController {
                let settingsController = navController.topViewController as? SettingsTableViewController
                settingsController?.settings = settings
            }
        }
        
        
//        else if segue.destination is UINavigationController {
//            let settingsView = segue.destination as? SettingsTableViewController
//            settingsView?.settings = settings
//        } else if segue.destination is HistoryTableViewController {
//
//        }
    }

}

