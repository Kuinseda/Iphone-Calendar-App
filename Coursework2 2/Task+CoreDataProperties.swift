//
//  Task+CoreDataProperties.swift
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

extension Task {

    @NSManaged var complete: NSNumber?
    @NSManaged var cwkName: String?
    @NSManaged var days: NSNumber?
    @NSManaged var endTime: String?
    @NSManaged var notes: String?
    @NSManaged var startTime: String?
    @NSManaged var taskDueDate: String?
    @NSManaged var taskName: String?
    @NSManaged var taskReminder: NSNumber?
    @NSManaged var taskToCw: Coursework?

}
