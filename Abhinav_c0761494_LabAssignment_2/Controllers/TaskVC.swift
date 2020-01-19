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
        taskProgressField.delegate = self
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        taskTextView.text = ""
        taskTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        taskProgressField.text = ""
        
    }
    
    
    

    @IBAction func addTaskPressed(_ sender: UIButton) {
        
        if taskProgressField.text != "" && taskTextView.text != "" && dateTextFields[0].text != "" && dateTextFields[1].text != "" && dateTextFields[2].text != ""{
            
            taskDescription = taskTextView.text!
             date = dateTextFields[0].text! + "/" + dateTextFields[1].text! + "/" + dateTextFields[2].text!
            
           
           saveData()
            navigationController?.popToRootViewController(animated: true)
        }
        
        
        
       
               
          
              
               
              
       
        
    }
    
    func saveData(){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        
        let data = Task(context: managedContext)
        data.taskDescription = taskDescription
        data.taskDate = date
        data.progress = Int32(taskProgressField.text!)!
        
        
        do {
            try managedContext.save()
            print("saved Successfully")
        } catch  {
            print(error)
        }
        
        
        
        
        
    }
    
    
    
    
    
}

