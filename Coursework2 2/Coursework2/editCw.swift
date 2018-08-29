//
//  editCw.swift
//  Coursework2
//
//  Created by xcode on 12/05/2016.
//  Copyright © 2016 Shakil Campbell. All rights reserved.
//

import UIKit
import CoreData

class editCw: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var eModName: UITextField!
    @IBOutlet weak var eCwName: UITextField!
    @IBOutlet weak var eNotes: UITextField!
    @IBOutlet weak var eDueDate: UITextField!
    @IBOutlet weak var eModLvl: UITextField!
    @IBOutlet weak var eMarks: UITextField!
    @IBOutlet weak var eValue: UITextField!
    @IBOutlet weak var eRDate: UISwitch!
    
    
    var mName = String()
    
    var mLvl = String()
    
    var cName = String()
    
    var cvalue = String()
    
    var cmarks = String()
    
    var ddate = String()
    
    var cnotes = String()
    
    var reminder = String()
    

    
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
        
        eModLvl.delegate = self
        eValue.delegate = self
        
        eMarks.delegate = self
        eModLvl.keyboardType = UIKeyboardType.NumberPad
        eValue.keyboardType = UIKeyboardType.NumberPad
        eMarks.keyboardType = UIKeyboardType.NumberPad
        
        eModName.text = mName
        
        eModLvl.text = mLvl
        
        eCwName.text = cName
        
        eValue.text = cvalue
        
        eMarks.text = cmarks
        
        eDueDate.text = ddate
        
        eNotes.text = cnotes
        
        if reminder == "1"
            
        {
            //print(reminder)
            eRDate.setOn(true, animated: true)
            
        } else {
            
            eRDate.setOn(false, animated: false)
            
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
    @IBAction func edCwrk(sender: AnyObject) {
        
            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let entityDescription = NSEntityDescription.entityForName("Coursework", inManagedObjectContext: self.managedObjectContext)
            
            //let cwk = Coursework(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
            
            
            
            let fetchRequest = NSFetchRequest()
            
            fetchRequest.entity = entityDescription
            
            fetchRequest.predicate = NSPredicate(format: "cwkName = %@", eCwName.text!)
            

            //appdelegate.saveContext()
        
        
            do {
                
                let result = try appdelegate.managedObjectContext.executeFetchRequest(fetchRequest)
                
                print(result)
                
                if result.count != 0{
                    
                    let match = result[0] as! NSManagedObject
                    
                    match.setValue(eNotes.text, forKey: "notes")
                    match.setValue(Float(eMarks.text!), forKey: "marks")
                    match.setValue(eModName.text, forKey: "modName")
                    match.setValue(Int(eValue.text!), forKey: "value")
//                    match.setValue(eCwName.text, forKey: "cwkName")
                    match.setValue(eDueDate.text, forKey: "duedate")
                   // match.setValue(eRDate, forKey: "reminderdate")
                    match.setValue(eModLvl.text, forKey: "modlvl")
                    if (eRDate.on){
                        
                        match.setValue(true, forKey:"reminderdate")
                        
                    }
                        
                    else
                        
                    {
                        
                        match.setValue(false, forKey:"reminderdate")
                        
                    }
                    appdelegate.saveContext()
                    
                    
                    
                }
                
                
                
            } catch {
                
                let fetchError = error as NSError
                
                print(fetchError)
                
            }
            
        }
        
        
        
        
        
        
        
        //let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        //let context: NSManagedObjectContext = appDelegate.managedObjectContext
        
        
        //*************Batch Update************\\
//        let entityDescription = NSEntityDescription.entityForName("Coursework", inManagedObjectContext: context)
//        
//        // Initialize Batch Update Request
//        
//        let batchUpdateRequest = NSBatchUpdateRequest(entity: entityDescription!)
//        
//        // Configure Batch Update Request
//        
//        batchUpdateRequest.resultType = .UpdatedObjectIDsResultType
//        
//        batchUpdateRequest.propertiesToUpdate = ["notes": eNotes.text!]
        
//        
//        
//        do {
//            // Execute Batch Request
//            let batchUpdateResult = try context.executeRequest(batchUpdateRequest) as! NSBatchUpdateResult
//            
//            // Extract Object IDs
//            let objectIDs = batchUpdateResult.result as! [NSManagedObjectID]
//            for objectID in objectIDs {
//                
//                // Turn Managed Objects into Faults
//                
//                let managedObject = context.objectWithID(objectID)
//                
//                context.refreshObject(managedObject, mergeChanges: false)
//                
//            }
//        }catch{
//            print("error")
//        }
//   //https://stackoverflow.com/questions/26345189/how-do-you-update-a-coredata-entry-that-has-already-been-saved-in-swift

    
    
}
