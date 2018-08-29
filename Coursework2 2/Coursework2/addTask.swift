//
//  addTask.swift
//  Coursework2
//
//  Created by xcode on 12/05/2016.
//  Copyright © 2016 Shakil Campebell. All rights reserved.
//

import UIKit
import CoreData
class addTask: UIViewController, NSFetchedResultsControllerDelegate {
    
   // @IBOutlet weak var progress: UISlider!
    @IBOutlet weak var tracker: UILabel!
    
    @IBOutlet weak var progress: UISlider!
    
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var estDays: UITextField!
    
    @IBOutlet weak var dueDate: UITextField!
    @IBOutlet weak var taskReminder: UISwitch!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var startTime: UITextField!
    //carry over cwkname from previous segue
    var cwkName = String()
    
    
    @IBAction func SliderChanged(sender: AnyObject) {
        let val = Int(progress.value)
        tracker.text = "\(val)"
    }
    
    @IBAction func sliderChange(sender: UISlider) {
        let val = Int(progress.value)
        tracker.text = "\(val)"
    }
    
    let datePickerView:UIDatePicker = UIDatePicker()
    //let date2:UIDatePicker = UIDatePicker()
    let fdate = NSDateFormatter()
    
    @IBAction func duedateedit(sender: UITextField) {
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("datechanged:"), forControlEvents: .ValueChanged)
    }
    
    
    
    func datechanged(sender: UIDatePicker){
        if sender == datePickerView
        {
            fdate.dateStyle = .ShortStyle
            dueDate.text = fdate.stringFromDate(sender.date)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addTask(sender: AnyObject) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext

        let addtask = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: context)
        addtask.setValue(taskName.text, forKey: "taskName")
        addtask.setValue(startTime.text, forKey:"startTime")
        addtask.setValue(dueDate.text, forKey:"taskDueDate")
        addtask.setValue(Int(estDays.text!), forKey:"days")
        addtask.setValue(notes.text!, forKey:"notes")
        addtask.setValue(Int(tracker.text!), forKey:"complete")
        addtask.setValue(cwkName, forKey: "cwkName")
   
        if taskReminder.on
        {
            addtask.setValue(true, forKey: "taskReminder")
        } else {
            addtask.setValue(false, forKey: "taskReminder")
        }
        
        
        do{
            try context.save()
        }catch{
            print("Saving data failed")
        }
        do{
            let request = NSFetchRequest(entityName: "Task")
            let results = try context.executeFetchRequest(request)
            for item in results as! [NSManagedObject]{
                let tskname = item.valueForKey("taskName")
                let complete = item.valueForKey("complete")
                let notes = item.valueForKey("notes")
                let startTime = item.valueForKey("startTime")
                let taskDueDate = item.valueForKey("taskDueDate")
                let taskReminder = item.valueForKey("taskReminder")
                let days = item.valueForKey("days")
                let cname = item.valueForKey("cwkName")
                print(tskname!, complete!, notes!, startTime!, taskDueDate, taskReminder, days, cname)
            }
        }catch{
            print("error")
        }
    }
}



