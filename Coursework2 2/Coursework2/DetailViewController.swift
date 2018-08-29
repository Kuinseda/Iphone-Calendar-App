//
//  DetailViewController.swift
//  Coursework2
//
//  Created by xcode on 10/05/2016.
//  Copyright © 2016 Michael Huynh. All rights reserved.
//

import UIKit
import CoreData
import EventKitUI
import EventKit

class DetailViewController: UIViewController{

    @IBOutlet weak var CourseworkName: UILabel!
    @IBOutlet weak var daysLeft: UILabel!

    @IBOutlet weak var ModuleName: UILabel!
    @IBOutlet weak var notesdisplay: UILabel!

    @IBOutlet weak var duedate: UILabel!
    
    @IBOutlet weak var modlevels: UILabel!
    
    @IBOutlet weak var marksawarded: UILabel!
    
    @IBOutlet weak var values: UILabel!
    @IBOutlet weak var reminderdate: UILabel!
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.CourseworkName {
                label.text = detail.valueForKey("cwkName")!.description
                ModuleName.text = detail.valueForKey("modName")?.description
                notesdisplay.text = detail.valueForKey("notes")?.description
                duedate.text = detail.valueForKey("duedate")?.description
                modlevels.text = detail.valueForKey("modlvl")?.description
                marksawarded.text = detail.valueForKey("marks")?.description
                values.text = detail.valueForKey("value")?.description
                reminderdate.text = detail.valueForKey("reminderdate")?.description
                
                
                
                let dateformatter = NSDateFormatter()
                let cal = NSCalendar.currentCalendar()
                dateformatter.dateFormat = "MM/dd/yy"
                let startdate: String = dateformatter.stringFromDate(NSDate())
                let enddate = duedate.text!
                print(startdate)
                print(enddate)
                
                
                
                let sdate: NSDate = dateformatter.dateFromString(startdate)!
                let edate: NSDate = dateformatter.dateFromString(enddate)!
                
                
                
                let unit:NSCalendarUnit = .Day
                
                let components = cal.components(unit, fromDate: sdate, toDate: edate, options: [])
                print(components.day)
                daysLeft.text = String(components.day)
                
                
                
                let daysvalue = Int(daysLeft.text!)
                
                if (daysvalue > 14){
                    
                    daysLeft.backgroundColor = UIColor.greenColor()
                }
                    
                else if(daysvalue < 7){
                    
                    daysLeft.backgroundColor = UIColor.orangeColor()
                    
                } else if (daysvalue < 2) {
                    
                    daysLeft.backgroundColor = UIColor.redColor()
                    
                } else {
                    
                    daysLeft.backgroundColor = UIColor.whiteColor()
                }
                

                
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Addcwk(sender: AnyObject) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        do{
            let request = NSFetchRequest(entityName: "Coursework")
            let results = try context.executeFetchRequest(request)
            for item in results as! [NSManagedObject]{
                let modname = item.valueForKey("modName")
                let cwkname = item.valueForKey("cwkName")
                let cwknotes = item.valueForKey("notes")
                print(modname!, cwkname!, cwknotes!)
            }
        }catch{
            print("An error occured!")
        }

    }
    
    
    @IBAction func evento(sender: AnyObject) {
        //event
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatusForEntityType(.Event){
        case .Authorized:
            insertEvent(eventStore)
        case .Denied:
            print("Access denied")
        case .NotDetermined:
            eventStore.requestAccessToEntityType(.Event, completion: {[weak self] (granted: Bool, error: NSError?) -> Void in
                if granted{
                    self!.insertEvent(eventStore)
                } else {
                    print("Access denied")
                }
                })
        default:
            print("Case Default")
        }
        
    }
    
    func insertEvent(store: EKEventStore){
        
        //let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        
        //let context: NSManagedObjectContext = appDelegate.managedObjectContext
//        let request = NSFetchRequest(entityName: "Coursework")
//        let results = try context.executeFetchRequest(request)
        
        let calendars = store.calendarsForEntityType(.Event)
        
        for calendar in calendars{
            // Update the user interface for the detail item.
            
            if calendar.title == "Calendar" {
                //var startDate = NSDate()
                
                //weeks time
                //start Date
                //startDate = NSDate()
                //startDate = startDate.dateByAddingTimeInterval(24 * 28 * 60 * 60)
                //2 hours
                //let endDate = startDate.dateByAddingTimeInterval(2 * 60 * 60)
                
                
                //create event
                let event = EKEvent(eventStore: store)
//                
//                if let detail = self.detailItem {
//                    
//                        event.title = detail.valueForKey("cwkName")!.description
//                        event.notes = detail.valueForKey("notes")!.description
//                        let dueDate = detail.valueForKey("duedate")!.description
//                        let dateFormater = NSDateFormatter()
//                        dateFormater.dateFormat = "MM/DD/YYYY"
//                        event.startDate = dateFormater.dateFromString(dueDate)!
//                        let endDate = event.startDate.dateByAddingTimeInterval(60 * 60)
//                        event.endDate = endDate
//                    
//                }
                
                if let detail = self.detailItem {
                    
                    event.title = detail.valueForKey("cwkName")!.description
                    event.notes = detail.valueForKey("notes")!.description
                    let dueDate = detail.valueForKey("duedate")!.description
                    
                    
                    
                    let usDateFormatter = NSDateFormatter.dateFormatFromTemplate("MMddyy", options: 0, locale: NSLocale(localeIdentifier: "en-US"))
                    
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = usDateFormatter
                    //formatter.dateFormat = "MM/DD/YYYY"
                    event.startDate = formatter.dateFromString(dueDate)!
                    //event.startDate = dateFormatter.dateFromString(dueDate)!
                    let endDate = event.startDate.dateByAddingTimeInterval(60 * 60)
                    event.endDate = endDate
                    print(dueDate + " " + "\(event.startDate)")
                }

                
                event.calendar = calendar
                //event.title = "courseWork 1 is due"

                //event.startDate = startDate
                
                //let endDate = startDate.dateByAddingTimeInterval(2 * 60 * 60)
                //event.endDate = endDate
                
//                // 3
//                var startDate = NSDate()
//                startDate = startDate.dateByAddingTimeInterval(24 * 28 * 60 * 60)
//                // 2 hours
                
                
                //create an alarm
                let alarm: EKAlarm = EKAlarm()
                alarm.relativeOffset = 7 * 0 * 0 * 0 //7 days before in seconds deadline, notification
                //add the alarm
                event.addAlarm(alarm)
                
                //save event in calendar
                do{
                    try store.saveEvent(event, span: .ThisEvent)
                }
                catch let error as NSError
                {
                    print("An error occured \(error)")
                }
                
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "editCw" {
            
            
            
            let nav = segue.destinationViewController as! UINavigationController
            
            let cwDetails = nav.topViewController as! editCw
            
            
            
            cwDetails.mName = ModuleName.text!
            
            cwDetails.mLvl = modlevels.text!
            
            cwDetails.cName = CourseworkName.text!
            
            cwDetails.cvalue = values.text!
            
            cwDetails.cmarks = marksawarded.text!
            
            cwDetails.ddate = duedate.text!
            
            cwDetails.cnotes = notesdisplay.text!
            
            cwDetails.reminder = reminderdate.text!
            //fill all options
            
            if segue.identifier == "showTask" {
                let nav = segue.destinationViewController as! UINavigationController
                let task = nav.topViewController as! TaskTableViewController
                //print("This is cwkname to task")
                //print(CourseworkName.text!)
                task.taskCwName = CourseworkName.text!
            }
            
            if segue.identifier == "addTask" {
                //let nav = segue.destinationViewController as! UINavigationController
                //let addtask:AddTaskController! = segue.destinationViewController as? AddTaskController
                //print(CourseworkName!.text)
                let nav = segue.destinationViewController as! UINavigationController
                let addtask = nav.topViewController as! addTask
                addtask.cwkName = CourseworkName!.text!
                
                
            }
            
            
        }
        
    }
   
}

