//
//  Coursework+CoreDataProperties.swift
//  Coursework2
//
//  Created by Starrk on 16/05/2016.
//  Copyright © 2016 Shakil Campbell. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Coursework {

    @NSManaged var cwkName: String?
    @NSManaged var duedate: String?
    @NSManaged var marks: NSNumber?
    @NSManaged var modlvl: String?
    @NSManaged var modName: String?
    @NSManaged var notes: String?
    @NSManaged var reminderdate: NSNumber?
    @NSManaged var value: NSNumber?
    @NSManaged var cwToTask: Task?

}
