//
//  GameEntity+CoreDataProperties.swift
//  RoShamBill
//
//  Created by Joel on 3/20/20.
//  Copyright © 2020 Joel. All rights reserved.
//
//

import Foundation
import CoreData


extension GameEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameEntity> {
        return NSFetchRequest<GameEntity>(entityName: "GameEntity")
    }

    @NSManaged public var datePlayed: Date?
    @NSManaged public var maxGuessNumber: Int16
    @NSManaged public var minGuessNumber: Int16
    @NSManaged public var numOfPlayers: Int16
    @NSManaged public var targetNumber: Int16
    @NSManaged public var winner: String?
    @NSManaged public var toRounds: NSSet?

}

// MARK: Generated accessors for toRounds
extension GameEntity {

    @objc(addToRoundsObject:)
    @NSManaged public func addToToRounds(_ value: RoundEntity)

    @objc(removeToRoundsObject:)
    @NSManaged public func removeFromToRounds(_ value: RoundEntity)

    @objc(addToRounds:)
    @NSManaged public func addToToRounds(_ values: NSSet)

    @objc(removeToRounds:)
    @NSManaged public func removeFromToRounds(_ values: NSSet)

}
