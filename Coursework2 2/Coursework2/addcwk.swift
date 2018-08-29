//
//  AddEvent.swift
//  Calendar
//
//  Created by xcode on 06/05/2016.
//  Copyright © 2016 xcode. All rights reserved.
//

import UIKit
import CoreData

class addcwk: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var modname: UITextField!
    @IBOutlet weak var modlvl: UITextField!
    @IBOutlet weak var cwkname: UITextField!
    @IBOutlet weak var cwkvalue: UITextField!
    @IBOutlet weak var marks: UITextField!
    @IBOutlet weak var duedate: UITextField!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var rdate: UISwitch!
 
    @IBOutlet weak var days: UITextField!
    
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
            duedate.text = fdate.stringFromDate(sender.date)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //duedate.delegate = self
        //reminderdate.delegate = self
        modlvl.delegate = self
        cwkvalue.delegate = self
        marks.delegate = self
        modlvl.keyboardType = UIKeyboardType.NumberPad
        cwkvalue.keyboardType = UIKeyboardType.NumberPad
        marks.keyboardType = UIKeyboardType.NumberPad
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCoursework(sender: AnyObject) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        
        let addCoursework = NSEntityDescription.insertNewObjectForEntityForName("Coursework", inManagedObjectContext: context)
        addCoursework.setValue(modname.text, forKey: "modName")
        addCoursework.setValue(cwkname.text, forKey:"cwkName")
        addCoursework.setValue(notes.text, forKey:"notes")
        addCoursework.setValue(modlvl.text, forKey:"modlvl")
        addCoursework.setValue(Float(marks.text!), forKey:"marks")
        addCoursework.setValue(Int(cwkvalue.text!), forKey:"value")
        addCoursework.setValue(duedate.text, forKey:"duedate")
        //addCoursework.setValue(rdate., forKey:"reminderdate")
        if rdate.on
        {
            addCoursework.setValue(true, forKey: "reminderdate")
        } else {
            addCoursework.setValue(false, forKey: "reminderdate")
        }
        do{
            try context.save()
        }catch{
            print("Saving data failed")
        }
        //print output
        do{
            let request = NSFetchRequest(entityName: "Coursework")
            let results = try context.executeFetchRequest(request)
            for item in results as! [NSManagedObject]{
                let mname = item.valueForKey("ModName")
                let cwname = item.valueForKey("cwkName")
                let cwnotes = item.valueForKey("notes")
                let mlvl = item.valueForKey("modlvl")
                let marks = item.valueForKey("marks")
                let values = item.valueForKey("value")
                let ddate = item.valueForKey("duedate")
                let rdate = item.valueForKey("reminderdate")
                print(mname!, cwname!, cwnotes!, mlvl!, marks, values, ddate, rdate)
            }
        }catch{
            print("error")
        }
    }
}