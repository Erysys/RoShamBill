//
//  SettingsEntity+CoreDataProperties.swift
//  RoShamBill
//
//  Created by Joel on 3/19/20.
//  Copyright © 2020 Joel. All rights reserved.
//
//

import Foundation
import CoreData


extension SettingsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SettingsEntity> {
        return NSFetchRequest<SettingsEntity>(entityName: "SettingsEntity")
    }

    @NSManaged public var minNumber: Int16
    @NSManaged public var maxNumber: Int16

}
