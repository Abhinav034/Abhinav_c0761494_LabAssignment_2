//
//  TaskVC.swift
//  Abhinav_c0761494_LabAssignment_2
//
//  Created by Abhinav Bhardwaj on 2020-01-19.
//  Copyright © 2020 Abhinav Bhardwaj. All rights reserved.
//

import UIKit
import CoreData
class TaskVC: UIViewController , UITextViewDelegate , UITextFieldDelegate{
    
    @IBOutlet weak var taskTextView: UITextView!
    
    @IBOutlet var dateTextFields: [UITextField]!
    
    
    
    @IBOutlet weak var taskProgressField: UITextField!
    
    
    var date: String = ""
    var taskDescription:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        taskTextView.delegate = self
        
            //taskProgressField.delegate = self
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        taskTextView.text = ""
        taskTextView.becomeFirstResponder()
        taskTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
       
    }
    
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dateTextFields[0].becomeFirstResponder()
        dateTextFields[1].becomeFirstResponder()
        dateTextFields[2].becomeFirstResponder()
        taskProgressField.becomeFirstResponder()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    

    @IBAction func addTaskPressed(_ sender: UIButton) {
        
        if taskProgressField.text != "" && taskTextView.text != "" && dateTextFields[0].text != "" && dateTextFields[1].text != "" && dateTextFields[2].text != "" && taskTextView.text != "Today's task..."{
            
             filter()
        }
        else{
           
            let alert = UIAlertController(title: "Empty Fields", message: "Please fill all the fields", preferredStyle: .alert)
             
             alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
         
    }
    
    func filter(){
        
        let date = Int(dateTextFields[0].text!)
        let month = Int(dateTextFields[1].text!)
        let year = Int(dateTextFields[2].text!)
        let currentYear = Calendar.current.component(.year, from: Date())
      //  let currentMonth = Calendar.current.component(.month, from: Date())
       // let currentDate = Calendar.current.component(.day, from: Date())
        
        
        if (date! > 31 || date! < 1 ) || (month! > 12 || month! < 1 ) || ( year! < currentYear) {
            
            
            let alert = UIAlertController(title: "Invalid Date format", message: "Please put a valid date", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           self.present(alert, animated: true, completion: nil)
        }
       
        else{
            
            taskDescription = taskTextView.text!
             
            self.date = dateTextFields[0].text! + "/" + dateTextFields[1].text! + "/" + dateTextFields[2].text!
            
            saveData()
             navigationController?.popToRootViewController(animated: true)
            
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    func saveData(){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        
        let data = Task(context: managedContext)
        data.taskDescription = taskDescription
        data.taskDate = date
        data.progress = Int16(taskProgressField.text!)!
        data.taskCompletionValue = Int16(0)
        
        do {
            try managedContext.save()
            print("saved Successfully")
        } catch  {
            print(error)
        }
        
        
        
        
        
    }
    
    
    
    
    
}

