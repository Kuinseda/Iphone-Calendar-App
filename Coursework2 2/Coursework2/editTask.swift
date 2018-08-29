//
//  editTask.swift
//  Coursework2
//
//  Created by Starrk on 15/05/2016.
//  Copyright © 2016 Shakil Campbell. All rights reserved.
//
import UIKit
import CoreData
import Foundation
class editTask: UIViewController {
    
    @IBOutlet weak var eTaskName: UITextField!
    @IBOutlet weak var eStartTime: UITextField!
    @IBOutlet weak var eEstDays: UITextField!
    @IBOutlet weak var eNotes: UITextField!
    @IBOutlet weak var eReminder: UISwitch!
    @IBOutlet weak var eTracker: UILabel!
    @IBOutlet weak var eDueDate: UITextField!
    @IBOutlet weak var eprogress: UISlider!

    
    var tTskName = String()
    
    var tStartTime = String()
    
    var cDueDate = String()
    
    var cEstDays = String()
    
    var cNotes = String()
    
    var creminder = String()
    
    var cComplete = String()
    
    var cwkName = String()
    
    @IBAction func sliderChange(sender: AnyObject) {
        let val = Int(eprogress.value)
        eTracker.text = "\(val)"
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
            eDueDate.text = fdate.stringFromDate(sender.date)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eTaskName.text = tTskName
        
        eStartTime.text = tStartTime
        
        eDueDate.text = cDueDate
        
        eEstDays.text = cEstDays
        
        eNotes.text = cNotes
        
        eTracker.text = cComplete
        
        eprogress.value = Float(cComplete)!
        
        if eReminder == "1"
            
        {
            //print(reminder)
            eReminder.setOn(true, animated: true)
            
        } else {
            
            eReminder.setOn(false, animated: false)
            
        }
        
        // Do any additional setup after loading the view.
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    @IBAction func edTask(sender: AnyObject) {
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let entityDescription = NSEntityDescription.entityForName("Task", inManagedObjectContext: self.managedObjectContext)
        
        //let cwk = Coursework(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = entityDescription
        
         fetchRequest.predicate = NSPredicate(format: "taskName = %@", eTaskName.text!)
        fetchRequest.predicate = NSPredicate(format: "cwkName = %@", cwkName)
        
        
        //appdelegate.saveContext()
        
        
        do {
            
            let result = try appdelegate.managedObjectContext.executeFetchRequest(fetchRequest)
            
            print(result)
            
            if result.count != 0{
                
                let match = result[0] as! NSManagedObject
                
                match.setValue(cwkName, forKey: "cwkName")
                match.setValue(eNotes.text, forKey: "notes")
                match.setValue(eTaskName.text, forKey: "taskName")
                match.setValue(eDueDate.text, forKey: "taskDueDate")
                match.setValue(Int(eEstDays.text!), forKey: "days")
                match.setValue(Int(eTracker.text!), forKey: "complete")
                // match.setValue(eRDate, forKey: "reminderdate")

                if (eReminder.on){
                    
                    match.setValue(true, forKey:"taskReminder")
                    
                }
                    
                else
                    
                {
                    
                    match.setValue(false, forKey:"taskReminder")
                    
                }
                appdelegate.saveContext()
                
                
                
            }
            
            
            
        } catch {
            
            let fetchError = error as NSError
            
            print(fetchError)
            
        }

    
    
}
}