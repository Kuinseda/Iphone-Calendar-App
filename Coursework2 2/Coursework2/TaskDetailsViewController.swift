//
//  TaskDetailViewController.swift
//  Coursework2
//
//  Created by xcode on 15/05/2016.
//  Copyright © 2016 Shakil Campbell. All rights reserved.
//

import UIKit
import EventKitUI
import EventKit
class TaskDetailsViewController: UIViewController {
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var estDay: UILabel!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var reminder: UILabel!
    @IBOutlet weak var complete: UILabel!
    
    var cwkName = String()
    
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        
        if let detail = self.detailItem {
            if let label = self.taskName {
                label.text = detail.valueForKey("taskName")!.description
                startTime.text = detail.valueForKey("startTime")?.description
                estDay.text = detail.valueForKey("days")?.description
                dueDate.text = detail.valueForKey("taskDueDate")?.description
                complete.text = detail.valueForKey("complete")?.description
                notes.text = detail.valueForKey("notes")?.description
                
                if detail.valueForKey("taskReminder")?.description == "1" {
                    reminder.text = "On"
                } else {
                    reminder.text = "Off"
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //pass label data through to be edited
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editTask" {
            
            let nav = segue.destinationViewController as! UINavigationController
            let taskDetails = nav.topViewController as! editTask
            
            taskDetails.tTskName = taskName.text!
            taskDetails.tStartTime = startTime.text!
            taskDetails.cEstDays = estDay.text!
            taskDetails.cDueDate = dueDate.text!
            taskDetails.creminder = reminder.text!
            taskDetails.cComplete = complete.text!
            taskDetails.cNotes = notes.text!
            taskDetails.cwkName = cwkName
            
        }
        /*
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        }
        */
    }
}