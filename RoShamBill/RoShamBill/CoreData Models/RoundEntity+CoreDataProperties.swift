//
//  RoundEntity+CoreDataProperties.swift
//  RoShamBill
//
//  Created by Joel on 3/20/20.
//  Copyright © 2020 Joel. All rights reserved.
//
//

import Foundation
import CoreData


extension RoundEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoundEntity> {
        return NSFetchRequest<RoundEntity>(entityName: "RoundEntity")
    }

    @NSManaged public var guess: Int16
    @NSManaged public var player: String?
    @NSManaged public var result: String?
    @NSManaged public var roundIndex: Int16
    @NSManaged public var toGame: GameEntity?

}
