//
//  RoShamBill.swift
//  RoShamBill
//
//  Created by Joel on 12/1/19.
//  Copyright © 2019 Joel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct Settings: Codable {
    var minNumber: Int
    var maxNumber: Int
    
    init(minNumber: Int, maxNumber: Int) {
        self.minNumber = minNumber
        self.maxNumber = maxNumber
    }
    
//    static var documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//    static var archiveURL = documentsDirectory.appendingPathComponent("settings").appendingPathExtension("plist")
//
//    static func saveToFile(settings: Settings) {
//        let encoder = PropertyListEncoder()
//        let encodedSettings = try? encoder.encode(settings)
//
//        try? encodedSettings?.write(to: Settings.archiveURL, options: .noFileProtection)
//    }
    
    static func saveToFile(settings: Settings) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Could not access the App Delegate")
        }
        
        let context = appDelegate.persistentContainer.viewContext
        var settingsData:[SettingsEntity]
        
        do {
            settingsData = try context.fetch(SettingsEntity.fetchRequest())
        } catch let err as NSError {
            fatalError("Unable to fetch Settings: \(err.description)")
        }
        if (settingsData.count == 0) {
            let settingsToAdd = SettingsEntity(entity: SettingsEntity.entity(), insertInto: context)
            
            settingsToAdd.setValue(settings.minNumber, forKey: "minNumber")
            settingsToAdd.setValue(settings.maxNumber, forKey: "maxNumber")
            appDelegate.saveContext()
        } else {
            let settingsToUpdate = settingsData[0]
            
            settingsToUpdate.setValue(settings.minNumber, forKey: "minNumber")
            settingsToUpdate.setValue(settings.maxNumber, forKey: "maxNumber")
            appDelegate.saveContext()
        }

    }

    static func loadFromFile() -> Settings {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Could not access the App Delegate")
        }
        
        let context = appDelegate.persistentContainer.viewContext
        var settingsData:[SettingsEntity]
        
        do {
            settingsData = try context.fetch(SettingsEntity.fetchRequest())
        } catch let err as NSError {
            fatalError("Unable to fetch Settings: \(err.description)")
        }
        if (settingsData.count == 0) {
            return Settings(minNumber: 1, maxNumber: 1000)
        } else {
            let settings = settingsData[0]
            return Settings(minNumber: Int(settings.minNumber), maxNumber: Int(settings.maxNumber))
        }
        
    }
}

struct History: Codable {
    var games: [Game]
    
    init() {
        self.games = []
    }
    
    static var documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static var archiveURL = documentsDirectory.appendingPathComponent("history").appendingPathExtension("plist")
    
    static func saveToFile(game: Game) {
//        let encoder = PropertyListEncoder()
//        let encodedHistory = try? encoder.encode(history)
//
//        try? encodedHistory?.write(to: History.archiveURL, options: .noFileProtection)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Could not access the App Delegate")
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let gameEntity = GameEntity(entity: GameEntity.entity(), insertInto: context)
        
        let rules:Rules = game.rules
        let rounds:[Round] = game.rounds
        
        gameEntity.setValue(rules.minGuessNumber, forKey: "minGuessNumber")
        gameEntity.setValue(rules.maxGuessNumber, forKey: "maxGuessNumber")
        gameEntity.setValue(rules.targetNumber, forKey: "targetNumber")
        gameEntity.setValue(rules.numOfPlayers, forKey: "numOfPlayers")
        gameEntity.setValue(game.rounds.last!.player, forKey: "winner")
        gameEntity.setValue(game.datePlayed, forKey: "datePlayed")
        
        for index in 0..<rounds.count {
            let roundToAdd = RoundEntity(entity: RoundEntity.entity(), insertInto: context)
            roundToAdd.setValue(rounds[index].player, forKey: "player")
            roundToAdd.setValue(rounds[index].guess, forKey: "guess")
            roundToAdd.setValue(rounds[index].result, forKey: "result")
            roundToAdd.setValue(index, forKey: "roundIndex")
            roundToAdd.setValue(gameEntity, forKey: "toGame")
            
            gameEntity.addToToRounds(roundToAdd)
        }

        appDelegate.saveContext()
        
    }
    
    static func loadFromFile() -> History {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Could not access the App Delegate")
        }
        
        let context = appDelegate.persistentContainer.viewContext
        var gamesData:[GameEntity]
        do {
            gamesData = try context.fetch(GameEntity.fetchRequest())
        } catch let err as NSError {
            fatalError("Unable to fetch Games: \(err.description)")
        }
        
        var history = History()
        
        for gameEntity in gamesData {
            var rounds:[Round] = []
            let roundsData:[RoundEntity] = gameEntity.toRounds?.allObjects as! [RoundEntity]

            
            for roundData in roundsData {
                let round:Round = Round(player: roundData.player!, guess: Int(roundData.guess), result: roundData.result!, index: Int(roundData.roundIndex))
                rounds.append(round)
            }
            
            rounds.sort { ($0.index < $1.index) }
            
            let rules:Rules = Rules(minGuessNumber: Int(gameEntity.minGuessNumber), maxGuessNumber: Int(gameEntity.maxGuessNumber), targetNumber: Int(gameEntity.targetNumber), numOfPlayers: Int(gameEntity.numOfPlayers))
            
            var gameToAdd = Game(rules: rules)
            gameToAdd.rounds = rounds
            gameToAdd.datePlayed = gameEntity.datePlayed ?? Date()
            
            history.games.append(gameToAdd)
            }
            return history
        }
}

struct Rules: Codable {
    var minGuessNumber: Int
    var maxGuessNumber: Int
    var targetNumber: Int
    var numOfPlayers: Int
    var players: [String]

    init(minGuessNumber: Int, maxGuessNumber: Int, targetNumber: Int, numOfPlayers: Int) {
        self.minGuessNumber = minGuessNumber
        self.maxGuessNumber = maxGuessNumber
        self.targetNumber = targetNumber
        self.numOfPlayers = numOfPlayers
        self.players = []
        for count in 1...numOfPlayers {
            self.players.append("Player \(count)")
        }
    }
}

struct Round: Codable {
    var player: String
    var guess: Int
    var result: String
    var index: Int
}

struct Game: Codable {
    var rules: Rules
    var rounds: [Round]
    var isGameFinished: Bool
    var currentPlayerIndex: Int
    var datePlayed: Date
    
    init(rules: Rules) {
        self.rules = rules
        self.rounds = []
        self.isGameFinished = false
        self.currentPlayerIndex = 0
        self.datePlayed = Date()
        
    }
    
    mutating func nextPlayer() {
        if currentPlayerIndex == (rules.numOfPlayers - 1) {
            currentPlayerIndex = 0
        } else {
            currentPlayerIndex += 1
        }
    }
    
    func isValidGuess(guess: Int) -> Bool {
        if guess < rules.minGuessNumber || guess > rules.maxGuessNumber {
            return false
        } else {
            return true
        }
    }
    
    mutating func playerGuess(guess: Int) -> String {
        if guess < rules.targetNumber {
            self.rules.minGuessNumber = guess + 1
            return "Higher!"
        } else if guess > rules.targetNumber {
            self.rules.maxGuessNumber = guess - 1
            return "Lower!"
        } else {
            self.isGameFinished = true
            return "Correct!"
        }
    }
}

